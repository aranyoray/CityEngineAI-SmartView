// To parse this JSON data, do
//
//     final cctvs = cctvsFromJson(jsonString);

import 'dart:convert';

List<CCTV> cctvsFromJson(String str) =>
    List<CCTV>.from(json.decode(str).map((x) => CCTV.fromJson(x)));
String cctvsToJson(List<CCTV> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

CCTV cctvFromJson(String str) => CCTV.fromJson(json.decode(str));
String cctvToJson(CCTV data) => json.encode(data.toJson());

class CCTV {
  CCTV({
    required this.cctvId,
    required this.cctvName,
    required this.cctvLinkAddress,
    required this.cctvPhysicalAddress,
    required this.cctvLatitude,
    required this.cctvLongitude,
  });

  int cctvId;
  String cctvName;
  String cctvLinkAddress;
  String cctvPhysicalAddress;
  double cctvLatitude;
  double cctvLongitude;
  bool loiteringAnalytics = false;
  bool intrusionAnalytics = false;
  bool violenceAnalytics = false;
  bool abandoneObjectAnalytics = false;
  bool fireDetectionAnalytics = false;

  factory CCTV.fromJson(Map<String, dynamic> json) => CCTV(
        cctvId: json["cctv_id"],
        cctvName: json["cctv_name"],
        cctvLinkAddress: json["cctv_link_address"],
        cctvPhysicalAddress: json["cctv_physical_address"],
        cctvLatitude: json["cctv_latitude"]?.toDouble(),
        cctvLongitude: json["cctv_longitude"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "cctv_id": cctvId,
        "cctv_name": cctvName,
        "cctv_link_address": cctvLinkAddress,
        "cctv_physical_address": cctvPhysicalAddress,
        "cctv_latitude": cctvLatitude,
        "cctv_longitude": cctvLongitude,
      };

  CCTV.withAnalytics(
      this.cctvId,
      this.cctvName,
      this.cctvLinkAddress,
      this.cctvPhysicalAddress,
      this.cctvLatitude,
      this.cctvLongitude,
      this.loiteringAnalytics,
      this.intrusionAnalytics,
      this.violenceAnalytics,
      this.abandoneObjectAnalytics,
      this.fireDetectionAnalytics);
}
