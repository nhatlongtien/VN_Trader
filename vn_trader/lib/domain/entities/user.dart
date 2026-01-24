/// Example entity - tầng domain
/// Entities là các đối tượng pure, không phụ thuộc vào framework bên ngoài
/// Chỉ chứa dữ liệu và logic nghiệp vụ cơ bản

class User {
  final String id;
  final String name;
  final String email;

  const User({
    required this.id,
    required this.name,
    required this.email,
  });

  @override
  String toString() => 'User(id: $id, name: $name, email: $email)';
}
