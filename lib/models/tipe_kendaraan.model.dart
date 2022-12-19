// To parse this JSON data, do
//
//     final tipeKendaraan = tipeKendaraanFromMap(jsonString);

import 'dart:convert';

TipeKendaraan tipeKendaraanFromMap(String str) =>
    TipeKendaraan.fromMap(json.decode(str));

String tipeKendaraanToMap(TipeKendaraan data) => json.encode(data.toMap());

class TipeKendaraan {
  TipeKendaraan({
    required this.idTipeKendaraan,
    required this.namaTipeKendaraan,
    required this.hargaAwal,
    required this.hargaPerjam,
    required this.hargaPermalam,
    required this.dendaHilang,
  });

  String idTipeKendaraan;
  String namaTipeKendaraan;
  int hargaAwal;
  int hargaPerjam;
  int hargaPermalam;
  int dendaHilang;

  factory TipeKendaraan.fromMap(Map<String, dynamic> json) => TipeKendaraan(
        idTipeKendaraan: json["id_tipe_kendaraan"],
        namaTipeKendaraan: json["nama_tipe_kendaraan"],
        hargaAwal: json["harga_awal"],
        hargaPerjam: json["harga_perjam"],
        hargaPermalam: json["harga_permalam"],
        dendaHilang: json["denda_hilang"],
      );

  Map<String, dynamic> toMap() => {
        "id_tipe_kendaraan": idTipeKendaraan,
        "nama_tipe_kendaraan": namaTipeKendaraan,
        "harga_awal": hargaAwal,
        "harga_perjam": hargaPerjam,
        "harga_permalam": hargaPermalam,
        "denda_hilang": dendaHilang,
      };
}

// {
//     "id_tipe_kendaraan": "A1",
//     "nama_tipe_kendaraan": "Motor",
//     "harga_awal": 5000,
//     "harga_perjam": 2000,
//     "harga_permalam": 10000,
//     "denda_hilang": 25000
// }
