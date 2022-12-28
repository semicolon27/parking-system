import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:parking_system/models/karcis.model.dart';
import 'package:parking_system/services/database.service.dart';
import 'package:parking_system/utils.dart';
import 'package:stacked/stacked.dart';

class KarcisKeluarVM extends BaseViewModel {
  // instance kelas DatabaseService
  final DatabaseService _dbService = DatabaseService();
  final Utils _utils = Utils();

  // form untuk input plat nomor untuk bikin karcis
  TextEditingController idKarcisController = TextEditingController();

  Karcis? karcis;
  DateTime _waktuAkhir = DateTime.now();

  void getKarcisData() async {
    // untuk mengaktifkan status sedang loading
    setBusy(true);
    try {
      karcis = await _dbService.getDataKarcis(idKarcisController.text);

      var dateFormat = DateFormat('yyyyMMddHHmmss');
      karcis!.waktuKeluar = dateFormat.format(_waktuAkhir);
      karcis!.isBayar = true;
      // Apabila list karcis kosong
    } on RangeError catch (err) {
      _utils.tampilInfoDialog(
        judul: 'Info',
        isi: 'Karcis dengan kode tersebut tidak ditemukan.',
      );
    } catch (err) {
      print(err);
      _utils.tampilInfoDialog(
        judul: 'Error',
        isi: 'Terjadi kesalahan saat akan mendapatkan data karcis.',
      );
    } finally {
      // untuk  menonaktifkan status loading
      setBusy(false);
    }
  }

  void bayarParkir() async {
    // untuk mengaktifkan status sedang loading
    setBusy(true);
    try {
      await _dbService.bayarParkir(karcis!);

      await _utils.tampilInfoDialog(
        judul: 'Info',
        isi: 'Berhasil bayar parkir.',
      );
      karcis = null;
      idKarcisController.text = '';
    } catch (err) {
      print(err);
      _utils.tampilInfoDialog(
        judul: 'Error',
        isi: 'Terjadi kesalahan saat akan membayar karcis.',
      );
    } finally {
      // untuk  menonaktifkan status loading
      setBusy(false);
    }
  }

  // return seperti "1 jam 12 menit"
  String getDurasiText() {
    // keluar fungsi apabila karcis null
    if (karcis == null) return "";

    String tanggalJam = karcis!.waktuMasuk;

    DateTime waktuAwal = _utils.parseTextTanggal(tanggalJam);

    int totalMenit = _waktuAkhir.difference(waktuAwal).inMinutes;
    int jam = (totalMenit / 60).floor();
    int menit = totalMenit - (jam * 60);

    return "$jam jam $menit menit";
  }

  int getDurasiJam() {
    // keluar fungsi apabila karcis null
    if (karcis == null) return 0;

    String tanggalJam = karcis!.waktuMasuk;
    DateTime waktuAwal = _utils.parseTextTanggal(tanggalJam);

    int totalMenit = _waktuAkhir.difference(waktuAwal).inMinutes;

    return (totalMenit / 60).floor();
  }

  int getTotalTarif() {
    // keluar fungsi apabila karcis null
    if (karcis == null) return 0;

    int durasiJam = getDurasiJam();
    int total = karcis!.hargaAwal + (durasiJam * karcis!.hargaPerjam);
    return total;
  }

  void clear() {
    karcis = null;
    idKarcisController.text = "";
    notifyListeners();
  }
}
