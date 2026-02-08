import 'package:supabase_flutter/supabase_flutter.dart';
import '../supabase/supabase_service.dart';
import '../errors/app_exception_mapper.dart';

class BaseRepository {
  SupabaseClient get client => SupabaseService.client;

  // ================= CORE =================

  Future<List<T>> getAll<T>({
    required String table,
    required T Function(Map<String, dynamic>) fromJson,
    String? orderBy,
    bool ascending = false,
  }) async {
    try {
      PostgrestTransformBuilder<PostgrestList> query = client.from(table).select();

      if (orderBy != null) {
        query = query.order(orderBy, ascending: ascending);
      }

      final res = await query;
      return (res as List)
          .map((e) => fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw mapSupabaseError(e);
    }
  }

  Future<T> getById<T>({
    required String table,
    required String id,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      final res = await client
          .from(table)
          .select()
          .eq('id', id)
          .single();
      return fromJson(res);
    } catch (e) {
      throw mapSupabaseError(e);
    }
  }

  Future<T> insert<T>({
    required String table,
    required Map<String, dynamic> data,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      final res = await client
          .from(table)
          .insert(data)
          .select()
          .single();
      return fromJson(res);
    } catch (e) {
      throw mapSupabaseError(e);
    }
  }

  Future<T> update<T>({
    required String table,
    required String id,
    required Map<String, dynamic> data,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      final res = await client
          .from(table)
          .update(data)
          .eq('id', id)
          .select()
          .single();
      return fromJson(res);
    } catch (e) {
      throw mapSupabaseError(e);
    }
  }

  Future<void> delete({
    required String table,
    required String id,
  }) async {
    try {
      await client.from(table).delete().eq('id', id);
    } catch (e) {
      throw mapSupabaseError(e);
    }
  }

  // ================= QUERY =================

  Future<List<T>> getWhere<T>({
    required String table,
    required Map<String, dynamic> filters,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      var query = client.from(table).select();
      filters.forEach((key, value) {
        query = query.eq(key, value);
      });
      final res = await query;
      return (res as List)
          .map((e) => fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw mapSupabaseError(e);
    }
  }

  Future<T?> getSingleWhere<T>({
    required String table,
    required String field,
    required dynamic value,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      final res = await client
          .from(table)
          .select()
          .eq(field, value)
          .limit(1);

      if ((res as List).isEmpty) return null;
      return fromJson(res.first as Map<String, dynamic>);
    } catch (e) {
      throw mapSupabaseError(e);
    }
  }

  // ================= PAGINATION =================

  Future<List<T>> getPaged<T>({
    required String table,
    required int page,
    required int limit,
    required T Function(Map<String, dynamic>) fromJson,
    String? orderBy,
    bool ascending = false,
  }) async {
    try {
      final from = (page - 1) * limit;
      final to = from + limit - 1;

      var query = client.from(table).select().range(from, to);

      if (orderBy != null) {
        query = query.order(orderBy, ascending: ascending);
      }

      final res = await query;
      return (res as List)
          .map((e) => fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw mapSupabaseError(e);
    }
  }

  // ================= COUNT =================

  Future<int> count({
    required String table,
    Map<String, dynamic>? filters,
  }) async {
    try {
      var query = client.from(table).select();

      filters?.forEach((key, value) {
        query = query.eq(key, value);
      });

      final response = await query.count(CountOption.exact);
      return response.count;
    } catch (e) {
      throw mapSupabaseError(e);
    }
  }

  Future<bool> exists({
    required String table,
    required String field,
    required dynamic value,
  }) async {
    try {
      final res = await client
          .from(table)
          .select('id')
          .eq(field, value)
          .limit(1);
      return (res as List).isNotEmpty;
    } catch (e) {
      throw mapSupabaseError(e);
    }
  }

  // ================= SOFT DELETE =================

  Future<void> softDelete({
    required String table,
    required String id,
  }) async {
    try {
      await client
          .from(table)
          .update({'deleted_at': DateTime.now().toIso8601String()})
          .eq('id', id);
    } catch (e) {
      throw mapSupabaseError(e);
    }
  }

  Future<void> restore({
    required String table,
    required String id,
  }) async {
    try {
      await client
          .from(table)
          .update({'deleted_at': null})
          .eq('id', id);
    } catch (e) {
      throw mapSupabaseError(e);
    }
  }

  // ================= BULK =================

  Future<void> insertMany({
    required String table,
    required List<Map<String, dynamic>> data,
  }) async {
    try {
      await client.from(table).insert(data);
    } catch (e) {
      throw mapSupabaseError(e);
    }
  }

  Future<void> deleteMany({
    required String table,
    required List<String> ids,
  }) async {
    try {
      await client.from(table).delete().inFilter('id', ids);
    } catch (e) {
      throw mapSupabaseError(e);
    }
  }

  // ================= RPC =================

  Future<R> callRpc<R>(
      String functionName, {
        Map<String, dynamic>? params,
      }) async {
    try {
      return await client.rpc(functionName, params: params) as R;
    } catch (e) {
      throw mapSupabaseError(e);
    }
  }
}
