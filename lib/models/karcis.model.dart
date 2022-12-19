// To parse this JSON data, do
//
//     final karcis = karcisFromMap(jsonString);

import 'dart:convert';

Karcis karcisFromMap(String str) => Karcis.fromMap(json.decode(str));

String karcisToMap(Karcis data) => json.encode(data.toMap());

class Karcis {
  Karcis({
    this.idKarcis = '',
    this.platNomor = '',
    this.idTipeKendaraan = '',
    this.isBayar = false,
    this.waktuMasuk = '',
    this.waktuKeluar = '',
    this.namaTipeKendaraan = '',
    this.hargaAwal = 0,
    this.hargaPerjam = 0,
  });

  String idKarcis;
  String platNomor;
  String idTipeKendaraan;
  bool isBayar;
  String waktuMasuk;
  String waktuKeluar;
  String namaTipeKendaraan;
  int hargaAwal;
  int hargaPerjam;

  factory Karcis.fromMap(Map<String, dynamic> json) => Karcis(
        idKarcis: json["id_karcis"],
        platNomor: json["plat_nomor"],
        idTipeKendaraan: json["id_tipe_kendaraan"],
        isBayar: json["is_bayar"] == 1 ? true : false,
        waktuMasuk: json["waktu_masuk"],
        waktuKeluar: json["waktu_keluar"],
        namaTipeKendaraan: json["nama_tipe_kendaraan"],
        hargaAwal: json["harga_awal"],
        hargaPerjam: json["harga_perjam"],
      );

  Map<String, dynamic> toMap() => {
        "id_karcis": idKarcis,
        "plat_nomor": platNomor,
        "id_tipe_kendaraan": idTipeKendaraan,
        "is_bayar": isBayar ? 1 : 0,
        "waktu_masuk": waktuMasuk,
        "waktu_keluar": waktuKeluar,
        "nama_tipe_kendaraan": namaTipeKendaraan,
        "harga_awal": hargaAwal,
        "harga_perjam": hargaPerjam,
      };
}

// {
//     "id_karcis": "",
//     "plat_nomor": "F 1901 PT",
//     "id_tipe_kendaraan": "A1",
//     "is_bayar": true,
//     "waktu_masuk": "20221217150202",
//     "waktu_keluar": "20221217190202"
// }
