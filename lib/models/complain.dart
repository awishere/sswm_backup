class Complain {
  final String id;
  final String fullName;
  final String subject;
  final String address;
  final String description;
  final String extras;
  final String userID;
  final String status;
  final String vid;

  Complain(
      {this.id,
      this.fullName,
      this.subject,
      this.address,
      this.description,
      this.extras,
      this.status,
      this.userID,
      this.vid});

  factory Complain.fromJson(Map<String, dynamic> json) {
    return Complain(
        id: json['id'].toString(),
        fullName: json['fullName'],
        subject: json['subject'],
        address: json['address'],
        description: json['description'],
        extras: json['extras'],
        status: json['status'],
        vid: json['vid'],
        userID: json['userID'].toString());
  }
}
