import 'package:easy_table/easy_table.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parking_system/models/karcis.model.dart';
import 'package:parking_system/utils.dart';
import 'package:parking_system/vm/list_karcis.vm.dart';
import 'package:stacked/stacked.dart';

class ListKarcisPage extends StatelessWidget {
  const ListKarcisPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ListKarcisVM>.reactive(
      viewModelBuilder: () => ListKarcisVM(),
      // jalankan fungsi getListKarcis dari viewModel ketika halaman di load
      onModelReady: (model) => model.getListKarcis(),
      builder: (context, vm, child) {
        return Scaffold(
          body: CustomScrollView(
            slivers: <Widget>[
              // appbar atau navbar dari page
              const CupertinoSliverNavigationBar(
                // judul halaman
                largeTitle: Text('List Karcis'),
              ),
              // mengisi area widget yang kosong
              SliverFillRemaining(
                child: Padding(
                  // mensetting padding vertikal dan horizontal secara teripisah
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  // tabel dari package https://pub.dev/packages/easy_table
                  child: EasyTable<Karcis>(
                    EasyTableModel<Karcis>(
                      rows: vm.listKarcis,
                      columns: [
                        EasyTableColumn(
                          name: 'No.',
                          // mendapatkan index row dan menambahkannya dengan 1 untuk nomer urut di tabel
                          intValue: (row) => vm.listKarcis.indexOf(row) + 1,
                          width: 40,
                        ),
                        EasyTableColumn(
                          name: 'ID Karcis',
                          stringValue: (row) => row.idKarcis,
                          width: 300,
                        ),
                        EasyTableColumn(
                          name: 'Plat Nomor',
                          stringValue: (row) => row.platNomor,
                        ),
                        EasyTableColumn(
                          name: 'Tipe',
                          stringValue: (row) => row.namaTipeKendaraan,
                        ),
                        EasyTableColumn(
                          name: 'Status Bayar',
                          stringValue: (row) =>
                              row.isBayar ? 'Sudah Bayar' : 'Belum Bayar',
                        ),
                        EasyTableColumn(
                          name: 'Tarif',
                          // jika sudah bayar, maka hitung dan isi row tarif
                          // jika tidak maka kosong
                          stringValue: (row) => row.isBayar
                              ? Utils().formatNominal(vm.getTotalTarif(row))
                              : '',
                        ),
                        EasyTableColumn(
                          name: 'Waktu Masuk',
                          stringValue: (row) =>
                              Utils().formatTextTanggal(row.waktuMasuk),
                          width: 180,
                        ),
                        EasyTableColumn(
                          name: 'Waktu Keluar',
                          stringValue: (row) =>
                              Utils().formatTextTanggal(row.waktuKeluar),
                          width: 180,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
