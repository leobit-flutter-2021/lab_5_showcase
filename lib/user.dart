enum Gender { male, female }

class User {
  final String name;
  final String imageUrl;
  final Gender gender;
  final int age;

  User(this.name, this.imageUrl, this.gender, this.age);

  User.parse(Map<String, dynamic> map)
      : name = map['results'][0]['name']['first'],
        imageUrl = map['results'][0]['picture']['large'],
        gender = _parseGender(map['results'][0]['gender']),
        age = map['results'][0]['dob']['age'];
}

Gender _parseGender(String str) {
  return str == 'male' ? Gender.male : Gender.female;
}

String stringify(Gender gender) {
  return gender == Gender.male ? 'male' : 'female';
}
