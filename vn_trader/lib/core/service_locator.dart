/// Service Locator / Dependency Injection setup
///
/// This file is used to configure and provide instances of services,
/// repositories, and BLoCs throughout the application.
///
/// Usage:
/// ```dart
/// final serviceLocator = ServiceLocator.instance;
/// final myBloc = serviceLocator<MyBloc>();
/// ```

class ServiceLocator {
  static final ServiceLocator _instance = ServiceLocator._internal();

  factory ServiceLocator() {
    return _instance;
  }

  ServiceLocator._internal();

  static ServiceLocator get instance => _instance;

  final Map<Type, dynamic> _services = {};

  /// Register a service
  void register<T>(T service) {
    _services[T] = service;
  }

  /// Retrieve a registered service
  T get<T>() {
    final service = _services[T];
    if (service is! T) {
      throw Exception('Service of type $T not found');
    }
    return service;
  }
}
