// untuk DateFormat
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Utils {
  // mendapatkan tanggal dengan contoh format 20221203183055
  String getTanggalJam() {
    var dateFormat = DateFormat('yyyyMMddhhmmss');
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
    return DateFormat('yyyy-MM-dd hh:mm:ss')
        .parse('$tahun-$bulan-$hari $jam:$menit:$detik');
  }

  String formatTextTanggal(String value) {
    String tahun = value.substring(0, 4);
    String bulan = value.substring(4, 6);
    String hari = value.substring(6, 8);
    String jam = value.substring(8, 10);
    String menit = value.substring(10, 12);
    String detik = value.substring(12, 14);
    return '$tahun-$bulan-$hari $jam:$menit:$detik';
  }
}
