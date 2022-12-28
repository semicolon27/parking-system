// untuk DateFormat
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Utils {
  // mendapatkan tanggal dengan contoh format 20221203183055
  String getTanggalJam() {
    var dateFormat = DateFormat('yyyyMMddHHmmss');
    return dateFormat.format(DateTime.now());
  }

  Future<void> tampilInfoDialog(
      {String judul = 'Alert', String isi = ''}) async {
    await showCupertinoModalPopup<void>(
      context: Get.context!,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(judul),
        content: Text(isi),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            /// This parameter indicates the action would perform
            /// a destructive action such as deletion, and turns
            /// the action's text color to red.
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  String formatNominal(dynamic nominal, [int decimalDigits = 0]) {
    var number = NumberFormat.currency(
            locale: 'id', symbol: '', decimalDigits: decimalDigits)
        .format(nominal);
    return number;
  }

  DateTime parseTextTanggal(String value) {
    String tahun = value.substring(0, 4);
    String bulan = value.substring(4, 6);
    String hari = value.substring(6, 8);
    String jam = value.substring(8, 10);
    String menit = value.substring(10, 12);
    String detik = value.substring(12, 14);
    return DateFormat('yyyy-MM-dd HH:mm:ss')
        .parse('$tahun-$bulan-$hari $jam:$menit:$detik');
  }

  // mengubah dari 20221224183021 menjadi 2022-12-24 18:30:21
  // atau null jika terjadi error
  DateTime? parseTextTanggalOrNull(String value) {
    try {
      String tahun = value.substring(0, 4);
      String bulan = value.substring(4, 6);
      String hari = value.substring(6, 8);
      String jam = value.substring(8, 10);
      String menit = value.substring(10, 12);
      String detik = value.substring(12, 14);
      return DateFormat('yyyy-MM-dd HH:mm:ss')
          .parse('$tahun-$bulan-$hari $jam:$menit:$detik');
    } catch (err) {
      return null;
    }
  }

  // mengubah dari 20221224183021 menjadi 2022-12-24 18:30:21
  String formatTextTanggal(String value) {
    try {
      String tahun = value.substring(0, 4);
      String bulan = value.substring(4, 6);
      String hari = value.substring(6, 8);
      String jam = value.substring(8, 10);
      String menit = value.substring(10, 12);
      String detik = value.substring(12, 14);
      return '$tahun-$bulan-$hari $jam:$menit:$detik';
    } catch (err) {
      return '';
    }
  }
}
