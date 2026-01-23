class User {
  final String gender;
  final String title;
  final String firstName;
  final String lastName;
  final String fullName;
  final String email;
  final String phone;
  final String cell;
  final String city;
  final String country;
  final String pictureLarge;

  User({
    required this.gender,
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.cell,
    required this.city,
    required this.country,
    required this.pictureLarge,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    final name = json['name'] as Map<String, dynamic>;
    final location = json['location'] as Map<String, dynamic>;

    return User(
      gender: json['gender'] ?? 'unknown',
      title: name['title'] ?? '',
      firstName: name['first'] ?? '',
      lastName: name['last'] ?? '',
      fullName: '${name['first'] ?? ''} ${name['last'] ?? ''}'.trim(),
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      cell: json['cell'] ?? '',
      city: location['city'] ?? '',
      country: location['country'] ?? '',
      pictureLarge: (json['picture'] as Map<String, dynamic>?)?['large'] ?? '',
    );
  }
}