class Category {
  int option;
  String name;
  int count;
  String subtext;

  Category({
    required this.option,
    required this.name,
    required this.count,
    required this.subtext,
  });

  Map<String, dynamic> toMap() {
    return {
      'option': this.option,
      'name': this.name,
      'count': this.count,
      'subtext': this.subtext,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      option: map['option'] as int,
      name: map['name'] as String,
      count: map['count'] as int,
      subtext: map['subtext'] as String,
    );
  }
}

class Legend {
  int owner;
  String name;
  String job;

  Legend({
    required this.owner,
    required this.name,
    required this.job,
  });

  Map<String, dynamic> toMap() {
    return {
      'owner': this.owner,
      'name': this.name,
      'job': this.job,
    };
  }

  factory Legend.fromMap(Map<String, dynamic> map) {
    return Legend(
      owner: map['owner'] as int,
      name: map['name'] as String,
      job: map['job'] as String,
    );
  }
}

class Thoughts {
  int owner;
  int option;
  String name;
  int likes;
  int id;

  Thoughts({
    required this.owner,
    required this.option,
    required this.name,
    required this.likes,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'owner': this.owner,
      'option': this.option,
      'text': this.name,
      'likes': this.likes,
      'id': id,
    };
  }

  factory Thoughts.fromMap(Map<String, dynamic> map) {
    return Thoughts(
      owner: map['owner'] as int,
      option: map['option'] as int,
      name: map['text'] as String,
      likes: map['likes'] as int,
      id: map['id'] as int,
    );
  }
}

class TopClass {
  String image;
  String name;
  String dob;
  String job;

  TopClass({
    required this.image,
    required this.name,
    required this.dob,
    required this.job,
  });
}

List<TopClass> topclass = [
  TopClass(
      image: 'assets/images/muhamed.jpg',
      name: 'Prophet Muhamed',
      dob: 'c. 570–632',
      job: 'Spiritual and political Leader'),
  TopClass(
      image: 'assets/images/newton.jpg',
      name: 'Issac Newton',
      dob: '1643–1727',
      job: 'Scientist'),
  TopClass(
      image: 'assets/images/jesus.jpg',
      name: 'Jesus Christ',
      dob: '4 BC–33 AD',
      job: 'Spiritual leader'),
  TopClass(
      image: 'assets/images/Buddha.webp',
      name: 'Buddha',
      dob: '563–483 BC',
      job: 'Spiritual leader'),
  TopClass(
      image: 'assets/images/Confucius.webp',
      name: 'Confucius',
      dob: '551–479 BC',
      job: 'Philosopher'),
];
