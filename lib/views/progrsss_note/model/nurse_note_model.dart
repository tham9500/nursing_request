class NurseNoteModel {
  NurseNoteModel({
    required this.patientName,
    required this.age,
    required this.hn,
    required this.an,
    required this.department,
    required this.attending,
    required this.ward,
    required this.date,
    required this.focus,
    required this.note,
    required this.name,
  });

  final String? patientName;
  final String? age;
  final String? hn;
  final String? an;
  final String? department;
  final String? attending;
  final String? ward;
  final String? date;
  final String? focus;
  final String? note;
  final String? name;

  factory NurseNoteModel.fromJson(Map<String, dynamic> json) {
    return NurseNoteModel(
      patientName: json["patient_name"],
      age: json["age"],
      hn: json["hn"],
      an: json["an"],
      department: json["department"],
      attending: json["attending"],
      ward: json["ward"],
      date: json["date"],
      focus: json["focus"],
      note: json["note"],
      name: json["name"],
    );
  }
}
