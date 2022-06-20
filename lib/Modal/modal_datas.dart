class UserModal {
  String? id;
  String? name;
  String? phone;
  String? age;
  String? status;
  String? doctorId;
  String? date;

  UserModal(
      {this.id,
      this.name,
      this.phone,
      this.age,
      this.status,
      this.doctorId,
      this.date});

  toJson() => {
        "age": age,
        "id": id,
        "phone_no": phone,
        "status": status,
        "user_name": name,
        "doctor_id": doctorId,
        "date": date
      };

  static UserModal fromJson(Map<String, dynamic> json) => UserModal(
      id: json["id"],
      name: json["user_name"],
      age: json["age"],
      phone: json["phone_no"],
      status: json["stats"],
      doctorId: json["doctor_id"],
      date: json['date']);
}

class DoctorModal {
  String? doc_id;
  String? phone;
  String? doc_firstName;
  String? doc_lastName;

  DoctorModal({this.doc_id, this.phone, this.doc_firstName, this.doc_lastName});
}
