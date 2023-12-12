class ClockInOutModel {
  final int id;
  // ignore: non_constant_identifier_names
  final String CheckDate;
  // ignore: non_constant_identifier_names
  final String TimeIn;
  // ignore: non_constant_identifier_names
  final String TimeOut;
  // ignore: non_constant_identifier_names
  final int Userid;
  // ignore: non_constant_identifier_names
  final String Name;

  const ClockInOutModel(
      {required this.id,
      // ignore: non_constant_identifier_names
      required this.CheckDate,
      // ignore: non_constant_identifier_names
      required this.TimeIn,
      // ignore: non_constant_identifier_names
      required this.TimeOut,
      // ignore: non_constant_identifier_names
      required this.Name,
      // ignore: non_constant_identifier_names
      required this.Userid});

  factory ClockInOutModel.fromJson(Map<String, dynamic> json) {
    // print(json);
    return ClockInOutModel(
      id: json['id'],
      CheckDate: json['CheckDate'],
      TimeIn: json['TimeIn'],
      TimeOut: json['TimeOut'] ?? "0.00",
      Name: json['Name'],
      Userid: json['Userid'],
    ); //  as String);
  }
}
