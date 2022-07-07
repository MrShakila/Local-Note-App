class NoteModel {
  int? id;
  String title;
  String desc;

  NoteModel({
    required this.title,
    required this.desc,
    required this.id,
  });

  static NoteModel fromMap(Map<String, dynamic> json) {
    return NoteModel(
      title: json['title'],
      desc: json['description'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'description': desc,
      };
}
