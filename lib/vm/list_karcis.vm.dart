import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:parking_system/models/karcis.model.dart';
import 'package:parking_system/services/database.service.dart';
import 'package:parking_system/utils.dart';
import 'package:stacked/stacked.dart';

// untuk randomAlpha
import 'package:random_string/random_string.dart';

class ListKarcisVM extends BaseViewModel {
  final DatabaseService _dbService = DatabaseService();
  final Utils _utils = Utils();

  List<Karcis> listKarcis = [];

  void getListKarcis() async {
    setBusy(true);
    try {
      listKarcis = await _dbService.getListDataKarcis();
    } catch (err) {
      _utils.tampilInfoDialog(
        judul: 'Error',
        isi: 'Terjadi kesalahan saat akan mendapatkan data karcis.',
      );
    } finally {
      setBusy(false);
    }
  }
}
