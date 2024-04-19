import 'dart:convert';

List<DeviceModel> deviceModelFromJson(String str) => List<DeviceModel>.from(
    json.decode(str).map((x) => DeviceModel.fromJson(x)));

String deviceModelToJson(List<DeviceModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DeviceModel {
  String imei;
  String protocol;
  String netProtocol;
  String ip;
  String port;
  String active;
  String objectExpire;
  DateTime objectExpireDt;
  String dtServer;
  String dtTracker;
  String lat;
  String lng;
  String altitude;
  String angle;
  String speed;
  Params params;
  String locValid;
  String dtLastStop;
  String dtLastIdle;
  String dtLastMove;
  String name;
  String device;
  String simNumber;
  String model;
  String vin;
  String plateNumber;
  String odometer;
  String engineHours;
  List<dynamic> customFields;

  DeviceModel({
    required this.imei,
    required this.protocol,
    required this.netProtocol,
    required this.ip,
    required this.port,
    required this.active,
    required this.objectExpire,
    required this.objectExpireDt,
    required this.dtServer,
    required this.dtTracker,
    required this.lat,
    required this.lng,
    required this.altitude,
    required this.angle,
    required this.speed,
    required this.params,
    required this.locValid,
    required this.dtLastStop,
    required this.dtLastIdle,
    required this.dtLastMove,
    required this.name,
    required this.device,
    required this.simNumber,
    required this.model,
    required this.vin,
    required this.plateNumber,
    required this.odometer,
    required this.engineHours,
    required this.customFields,
  });

  factory DeviceModel.fromJson(Map<String, dynamic> json) => DeviceModel(
        imei: json["imei"],
        protocol: json["protocol"],
        netProtocol: json["net_protocol"],
        ip: json["ip"],
        port: json["port"],
        active: json["active"],
        objectExpire: json["object_expire"],
        objectExpireDt: DateTime.parse(json["object_expire_dt"]),
        dtServer: json["dt_server"],
        dtTracker: json["dt_tracker"],
        lat: json["lat"],
        lng: json["lng"],
        altitude: json["altitude"],
        angle: json["angle"],
        speed: json["speed"],
        params: Params.fromJson(json["params"]),
        locValid: json["loc_valid"],
        dtLastStop: json["dt_last_stop"],
        dtLastIdle: json["dt_last_idle"],
        dtLastMove: json["dt_last_move"],
        name: json["name"],
        device: json["device"],
        simNumber: json["sim_number"],
        model: json["model"],
        vin: json["vin"],
        plateNumber: json["plate_number"],
        odometer: json["odometer"],
        engineHours: json["engine_hours"],
        customFields: List<dynamic>.from(json["custom_fields"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "imei": imei,
        "protocol": protocol,
        "net_protocol": netProtocol,
        "ip": ip,
        "port": port,
        "active": active,
        "object_expire": objectExpire,
        "object_expire_dt":
            "${objectExpireDt.year.toString().padLeft(4, '0')}-${objectExpireDt.month.toString().padLeft(2, '0')}-${objectExpireDt.day.toString().padLeft(2, '0')}",
        "dt_server": dtServer,
        "dt_tracker": dtTracker,
        "lat": lat,
        "lng": lng,
        "altitude": altitude,
        "angle": angle,
        "speed": speed,
        "params": params.toJson(),
        "loc_valid": locValid,
        "dt_last_stop": dtLastStop,
        "dt_last_idle": dtLastIdle,
        "dt_last_move": dtLastMove,
        "name": name,
        "device": device,
        "sim_number": simNumber,
        "model": model,
        "vin": vin,
        "plate_number": plateNumber,
        "odometer": odometer,
        "engine_hours": engineHours,
        "custom_fields": List<dynamic>.from(customFields.map((x) => x)),
      };
}

class Params {
  String alarm;
  String? acc;

  Params({
    required this.alarm,
    this.acc,
  });

  factory Params.fromJson(Map<String, dynamic> json) => Params(
        alarm: json["alarm"],
        acc: json["acc"],
      );

  Map<String, dynamic> toJson() => {
        "alarm": alarm,
        "acc": acc,
      };
}
