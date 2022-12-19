import 'package:flutter/cupertino.dart';
import 'package:parking_system/models/karcis.model.dart';
import 'package:parking_system/services/database.service.dart';
import 'package:parking_system/utils.dart';
import 'package:stacked/stacked.dart';

// untuk randomAlpha
import 'package:random_string/random_string.dart';

class KarcisMasukVM extends BaseViewModel {
  final DatabaseService _dbService = DatabaseService();
  final Utils _utils = Utils();

  // form untuk input plat nomor untuk bikin karcis
  TextEditingController platNomorController = TextEditingController();

  String _idTipeKendaraan = '';
  String get idTipeKendaraan => _idTipeKendaraan;
  set idTipeKendaraan(String idTipeKendaraan) {
    _idTipeKendaraan = idTipeKendaraan;
    notifyListeners();
  }

  void buatKarcis() async {
    // untuk mengaktifkan status sedang loading
    setBusy(true);
    try {
      Karcis karcis = Karcis(
        idKarcis: randomAlpha(5), // mendapatkan 5 buah huruf random
        idTipeKendaraan: idTipeKendaraan,
        isBayar: false,
        platNomor: platNomorController.text,
        waktuMasuk: _utils.getTanggalJam(),
        waktuKeluar: '',
      );
      await _dbService.buatKarcisMasuk(karcis);

      await _utils.tampilInfoDialog(
        judul: 'Sukses',
        isi: 'Karcis berhasil dibuat.',
      );

      // kosongin form
      platNomorController.text = '';
    } catch (err) {
      print(err);
      _utils.tampilInfoDialog(
        judul: 'Error',
        isi: 'Terjadi kesalahan saat akan membuat karcis.',
      );
    } finally {
      // untuk  menonaktifkan status loading
      setBusy(false);
    }
  }
}
