// ignore_for_file: unnecessary_new
class Case {
  final int? incidentid;
  final String incidentdescription;
  final String incidenttype;
  final int camid;
  final DateTime incidenttime;
  final String incidentmedia;
  final String assignee;
  final String prioritylevel;
  final String incidentstatus;
  final String? officerNotes;

  Case(
      {this.incidentid,
      required this.incidentdescription,
      required this.incidenttype,
      required this.camid,
      required this.incidenttime,
      required this.incidentmedia,
      required this.assignee,
      required this.prioritylevel,
      required this.incidentstatus,
      this.officerNotes});

  set officerNotes(String? message) {
    officerNotes = message;
  }

  factory Case.fromJson(Map<String, dynamic> json) {
    return Case(
      incidentid: json['incident_id'],
      incidentdescription: json['incident_description'],
      incidenttype: json['incident_type'],
      camid: json['cam_id'],
      incidenttime: DateTime.parse(json['incident_time']),
      incidentmedia: json['incident_media'].toString().toLowerCase() == "null"
          ? ""
          : json['incident_media'],
      assignee: json['assignee'],
      prioritylevel: json['priority_level'],
      incidentstatus: json['incident_status'],
      officerNotes: json['officer_notes'],
    );
  }
}
