import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parking_system/styles.dart';
import 'package:parking_system/utils.dart';
import 'package:parking_system/vm/karcis_keluar.vm.dart';
import 'package:stacked/stacked.dart';

class KarcisKeluarPage extends StatelessWidget {
  const KarcisKeluarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // memanggil kelas provider KarcisKeluarVM
    return ViewModelBuilder<KarcisKeluarVM>.reactive(
      viewModelBuilder: () => KarcisKeluarVM(),
      builder: (context, vm, child) {
        return Scaffold(
          body: CustomScrollView(
            slivers: <Widget>[
              const CupertinoSliverNavigationBar(
                largeTitle: Text('Karcis Keluar'),
              ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),
                    SizedBox(
                      width: 300,
                      child: CupertinoTextField(
                        controller: vm.idKarcisController,
                        placeholder: 'Kode Karcis',
                      ),
                    ),
                    // memberikan jarak dari button ke text field
                    const SizedBox(height: 10),
                    CupertinoButton.filled(
                      // kalau sedang busy atau sedang loading input, button akan menampilkan loading
                      padding: const EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 100,
                      ),
                      minSize: 35,
                      // kalau sedang busy atau sedang loading input, button dibuat null
                      // untuk onpressed nya agar tidak bisa di tekan
                      onPressed: vm.isBusy ? null : () => vm.getKarcisData(),
                      // kalau sedang busy atau sedang loading input, button akan menampilkan loading
                      child: vm.isBusy
                          ? const CupertinoActivityIndicator()
                          : const Text('Cek Karcis'),
                    ),

                    SizedBox(height: 30),
                    // tampilkan jika karcis tidak kosong atau null
                    if (vm.karcis != null)
                      Container(
                        width: 300,
                        height: 150,
                        child: vm.isBusy
                            ? CupertinoActivityIndicator()
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text('ID Karcis'),
                                      Text('Plat Nomor'),
                                      Text('Tipe Kendaraan'),
                                      Text('Waktu Masuk'),
                                      Text('Durasi'),
                                      Text('Tarif'),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text(' : '),
                                      Text(' : '),
                                      Text(' : '),
                                      Text(' : '),
                                      Text(' : '),
                                      Text(' : '),
                                    ],
                                  ),
                                  // biar mengisi ruang kosong/sisa, biar berjauhan
                                  Spacer(),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(vm.karcis!.idKarcis),
                                      Text(vm.karcis!.platNomor),
                                      Text(vm.karcis!.namaTipeKendaraan),
                                      Text(Utils().formatTextTanggal(
                                          vm.karcis!.waktuMasuk)),
                                      Text(vm.getDurasiText()),
                                      Text(Utils()
                                          .formatNominal(vm.getTotalTarif())),
                                    ],
                                  ),
                                ],
                              ),
                      ),

                    SizedBox(height: 20),
                    // tampilkan jika karcis tidak kosong atau null
                    if (vm.karcis != null)
                      CupertinoButton(
                        color: Styles.secondaryColor,
                        padding: const EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 100,
                        ),
                        minSize: 35,
                        // jika sedang loading atau busy, maka di set null agar tidak bisa di pencet tombolnya
                        // jika diklik  maka jalankan fungsi bayarParkir dari viewmodel
                        onPressed: vm.isBusy ? null : () => vm.bayarParkir(),
                        // jika sedang loading atau busy, maka pakai indikator loading. jika ngga tampil text bayar.
                        child: vm.isBusy
                            ? const CupertinoActivityIndicator()
                            : const Text('Bayar'),
                      ),

                    SizedBox(height: 10),
                    // tampilkan jika karcis tidak kosong atau null
                    if (vm.karcis != null)
                      CupertinoButton(
                        padding: const EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 100,
                        ),
                        minSize: 35,
                        onPressed: () => vm.clear(),
                        child: vm.isBusy
                            ? const CupertinoActivityIndicator()
                            : const Text(
                                'Bersihkan Hasil Pencarian',
                              ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
