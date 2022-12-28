import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking_system/pages/karcis_keluar.page.dart';
import 'package:parking_system/pages/karcis_masuk.page.dart';
import 'package:parking_system/pages/list_karcis.page.dart';
import 'package:parking_system/styles.dart';

class CupertinoStoreHomePage extends StatelessWidget {
  const CupertinoStoreHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Aplikasi Sistem Parkir'),
      ),
      child: Scaffold(
        // SafeArea: agar konten berada di bawah navbar dan tidak tertimpa navbar
        body: SafeArea(
          // SizedBox: menentukan ukuran widget, ini agar full penjang window
          child: SizedBox(
            width: Get.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                CupertinoButton(
                  child: const Text('Karcis Masuk'),
                  onPressed: () => Get.to(() => const KarcisMasukPage()),
                ),
                CupertinoButton(
                  child: const Text('Karcis Keluar'),
                  onPressed: () => Get.to(() => const KarcisKeluarPage()),
                ),
                CupertinoButton(
                  child: const Text('List Karcis'),
                  onPressed: () => Get.to(() => const ListKarcisPage()),
                ),
                CupertinoButton(
                  child: const Text('Exit Aplikasi'),
                  onPressed: () => exit(0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
