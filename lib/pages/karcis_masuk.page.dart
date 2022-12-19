import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parking_system/styles.dart';
import 'package:parking_system/vm/karcis_masuk.vm.dart';
import 'package:stacked/stacked.dart';

class KarcisMasukPage extends StatelessWidget {
  const KarcisMasukPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<KarcisMasukVM>.reactive(
      viewModelBuilder: () => KarcisMasukVM(),
      builder: (context, vm, child) {
        return Scaffold(
          body: CustomScrollView(
            slivers: <Widget>[
              const CupertinoSliverNavigationBar(
                largeTitle: Text('Karcis Masuk'),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    // biar agak kebawah
                    const SizedBox(height: 10),
                    if (vm.idTipeKendaraan == '')
                      Container(
                        height: 300,
                        alignment: Alignment.center,
                        child: Text('HARAP PILIH TIPE KENDARAAN'),
                      ),

                    if (vm.idTipeKendaraan == 'B1')
                      // ClipRRect mmebuat gambar menjadi membulat atau ada border radius
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          'https://momobil.id/news/wp-content/uploads/2022/10/Toyota-Supra-Mk4-1024x576.jpg',
                          height: 300,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    if (vm.idTipeKendaraan == 'A1')
                      // ClipRRect mmebuat gambar menjadi membulat atau ada border radius
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'assets/img/supra.jpg',
                          height: 300,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    const SizedBox(height: 10),
                    const Text(
                      'Jenis Karcis Kendaraan:',
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(height: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ButtonTipeKendaraan(
                          id: 'A1',
                          nama: 'Motor',
                          isKanan: false,
                          vm: vm,
                        ),
                        ButtonTipeKendaraan(
                          id: 'B1',
                          nama: 'Mobil',
                          isKanan: true,
                          vm: vm,
                        ),
                      ],
                    ),
                    // jarak pilih kendaraan dan input plat nomor
                    const SizedBox(height: 10),

                    SizedBox(
                      width: 300,
                      child: CupertinoTextField(
                        controller: vm.platNomorController,
                        placeholder: 'Plat Nomor',
                        // jika input berubah, maka tampilan akan merender ulang
                        onChanged: (value) => vm.notifyListeners(),
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
                      // kalau sedang busy atau sedang loading input atau belum pilih tipe kendaraan atau input plat nomor kosong, button dibuat null
                      // jika onpressed nya null, tombol tidak bisa di tekan
                      onPressed: vm.isBusy ||
                              vm.idTipeKendaraan == '' ||
                              vm.platNomorController.text == ''
                          ? null
                          : () => vm.buatKarcis(),
                      // kalau sedang busy atau sedang loading input, button akan menampilkan loading
                      child: vm.isBusy
                          ? const CupertinoActivityIndicator()
                          : const Text('Buat Karcis'),
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

class ButtonTipeKendaraan extends StatelessWidget {
  final String id;
  final String nama;
  final bool isKanan;
  final KarcisMasukVM vm;

  const ButtonTipeKendaraan({
    Key? key,
    required this.id,
    required this.nama,
    this.isKanan = false,
    required this.vm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => vm.idTipeKendaraan = id,
      child: Container(
        decoration: BoxDecoration(
          color: vm.idTipeKendaraan == id
              ? Styles.primaryColor
              : Colors.transparent,
          border: Border.all(
            color: Styles.primaryColor,
          ),
          borderRadius: BorderRadius.only(
            topLeft: isKanan ? Radius.zero : Radius.circular(5),
            bottomLeft: isKanan ? Radius.zero : Radius.circular(5),
            topRight: !isKanan ? Radius.zero : Radius.circular(5),
            bottomRight: !isKanan ? Radius.zero : Radius.circular(5),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 5,
        ),
        child: Text(
          nama,
          style: TextStyle(
            color:
                vm.idTipeKendaraan == id ? Colors.white : Styles.primaryColor,
          ),
        ),
      ),
    );
  }
}
