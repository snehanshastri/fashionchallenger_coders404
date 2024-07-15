
class User {
  final String uid;
  final String name;
  final String email;
  final List rewards;

  User({
    required this.uid,
    required this.name,
    required this.email,
    this.rewards=const[]
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      rewards: json['rewards']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'rewards': rewards,
    };
  }

}