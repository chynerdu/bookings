class UserModel {
  final dynamic id;
  final dynamic firstName;
  final dynamic lastName;
  final dynamic email;
  final dynamic avatar;

  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.avatar,
  });
  UserModel.fromJson(Map<String, dynamic> parsedData)
      : id = parsedData['id'],
        firstName = parsedData['first_name'],
        lastName = parsedData['last_name'],
        avatar = parsedData['avatar'],
        email = parsedData['email'];
}
