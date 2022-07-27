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
    DateTime? tarih;
  get getAciklama => this.aciklama;

 set setAciklama( aciklama) => this.aciklama = aciklama;

  get getBaslik => this.baslik;

 set setBaslik( baslik) => this.baslik = baslik;

  get getKonum => this.konum;

 set setKonum( konum) => this.konum = konum;

  get getTarih => this.tarih;

 set setTarih( tarih) => this.tarih = tarih;

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
