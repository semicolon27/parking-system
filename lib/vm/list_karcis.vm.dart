import 'package:parking_system/models/karcis.model.dart';
import 'package:parking_system/services/database.service.dart';
import 'package:parking_system/utils.dart';
import 'package:stacked/stacked.dart';

class ListKarcisVM extends BaseViewModel {
  // instance kelas DatabaseService
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

  int? getTotalTarif(Karcis karcis) {
    if (karcis.isBayar) {
      int durasiJam = getDurasiJam(karcis);
      int total = karcis.hargaAwal + (durasiJam * karcis.hargaPerjam);
      return total;
    }
    return null;
  }

  int getDurasiJam(Karcis karcis) {
    String tanggalJam = karcis.waktuMasuk;
    DateTime waktuAwal = _utils.parseTextTanggal(tanggalJam);

    int totalMenit = Utils()
        .parseTextTanggal(karcis.waktuKeluar)
        .difference(waktuAwal)
        .inMinutes;

    return (totalMenit / 60).floor();
  }
}
