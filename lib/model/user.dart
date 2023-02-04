class User1 {
  final String imagePath;
  final String name;
  final String email;
  final String phoneNumber;

  const User1(
      {required this.imagePath,
      required this.name,
      required this.email,
      required this.phoneNumber});

  User1 copy({
    String? imagePath,
    String? name,
    String? email,
    String? phoneNumber,
  }) =>
      User1(
          imagePath: imagePath ?? this.imagePath,
          name: name ?? this.name,
          email: email ?? this.email,
          phoneNumber: phoneNumber ?? this.phoneNumber);

  static User1 fromJson(Map<String, dynamic> json) => User1(
      imagePath: json['imagePath'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber']);

  Map<String, dynamic> toJson() => {
        'imagePath': imagePath,
        'name': name,
        'email': email,
        'phoneNumber': phoneNumber
      };
}
