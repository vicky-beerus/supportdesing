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
  bool? doc_status;

  DoctorModal(
      {this.doc_id,
      this.phone,
      this.doc_firstName,
      this.doc_lastName,
      this.doc_status});

  toJson() => {
        "doc_id": doc_id,
        "phone": phone,
        "doc_firestName": doc_firstName,
        "doc_lastName": doc_lastName,
        "doc_status": doc_status
      };

  static DoctorModal fromJson(Map<String, dynamic> json) => DoctorModal(
      doc_id: json["doc_id"],
      phone: json['phone'],
      doc_firstName: json['doc_firstname'],
      doc_lastName: json["doc_lastname"],
      doc_status: json["doc_status"]);
}

class MessageModal {
  String? message_id;
  String? doc_firstname;
  String? doc_lastname;
  String? message;

  MessageModal(
      {this.message_id, this.doc_firstname, this.doc_lastname, this.message});

  toJson() => {
        "doc_firstname": doc_firstname,
        "doc_lastname": doc_lastname,
        "id": message_id,
        "message": message,
      };

  static MessageModal fromJson(Map<String, dynamic> json) => MessageModal(
      doc_firstname: json["doc_firstname"],
      doc_lastname: json["doc_lastname"],
      message: json["message"],
      message_id: json["id"]);
}
