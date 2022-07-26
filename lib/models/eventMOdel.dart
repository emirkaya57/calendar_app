// To parse this JSON data, do
//
//     final event = eventFromJson(jsonString);

import 'dart:convert';

EventModel eventFromJson(String str) => EventModel.fromJson(json.decode(str));

String eventToJson(EventModel data) => json.encode(data.toJson());

class EventModel {
    EventModel({
        this.aciklama,
        this.baslik,
        this.konum,
        this.tarih,
    });

    String? aciklama;
    String? baslik;
    String? konum;
    String? tarih;

    factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
        aciklama: json["açıklama"],
        baslik: json["başlik"],
        konum: json["konum"],
        tarih: json["tarih"],
    );

    Map<String, dynamic> toJson() => {
        "açıklama": aciklama,
        "başlık": baslik,
        "konum": konum,
        "tarih": tarih,
    };
}
