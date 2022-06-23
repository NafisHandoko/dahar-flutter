import 'package:dahar/models/auth_user.dart';
import 'package:dahar/models/produk.dart';
import 'package:dahar/models/toko.dart';
import 'package:dahar/screens/add_product.dart';
import 'package:dahar/services/databases/produk_database.dart';
import 'package:dahar/services/databases/toko_database.dart';
import 'package:flutter/material.dart';
import 'package:dahar/global_styles.dart';
import 'package:dahar/components/back_appbar.dart';
import 'package:dahar/components/navbar.dart';
import 'package:provider/provider.dart';

class MenuToko extends StatelessWidget {
  final id_toko;
  const MenuToko({Key? key, this.id_toko}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<Toko>.value(
      initialData: Toko(),
      value: TokoDatabase(uid: id_toko).myToko,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: BackAppBar(
              title: 'Menu Toko',
            )),
        body: MenuTokoProvider(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddProduct()),
            );
          },
          backgroundColor: color1,
          child: Icon(Icons.add),
        ),
        bottomNavigationBar: const NavBar(),
      ),
    );
  }
}

class MenuTokoProvider extends StatelessWidget {
  const MenuTokoProvider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final toko = Provider.of<Toko>(context);
    AuthUser user = Provider.of<AuthUser>(context);
    return StreamProvider<List<Produk>>.value(
      initialData: [],
      value: ProdukDatabase(uid: user.uid).produkOnToko,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        color: Colors.white,
        child: ListView(shrinkWrap: true, children: [
          Column(
            children: [
              Stack(children: [
                Container(
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.only(bottom: 10),
                  // margin: const EdgeInsets.only(right: 15),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage("${toko.foto}"),
                          fit: BoxFit.cover),
                      shape: BoxShape.circle,
                      color: color1),
                ),
                Positioned(
                    bottom: 10,
                    right: 0,
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: colorBlueEdit,
                            boxShadow: [boxshadow2]),
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                    ))
              ]),
              Container(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    '${toko.nama}',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.only(left: 10),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colorBlueEdit,
                          boxShadow: [boxshadow2]),
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  )
                ]),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    '${toko.alamat}',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.only(left: 10),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colorBlueEdit,
                          boxShadow: [boxshadow2]),
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  )
                ]),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                    borderRadius: borderRadius2,
                    color: color1,
                    boxShadow: [boxshadow1]),
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/order_list');
                  },
                  child: Text(
                    'Daftar Pesanan',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Daganganmu',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
          ),
          MenuTokoBuilder()
        ]),
      ),
    );
  }
}

class MenuTokoBuilder extends StatelessWidget {
  const MenuTokoBuilder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final produk = Provider.of<List<Produk>>(context);
    return Center(
      child: Wrap(
        spacing: 20,
        runSpacing: 20,
        // children: [
        //   MenuTokoItem(),
        //   MenuTokoItem(),
        //   MenuTokoItem(),
        //   MenuTokoItem(),
        //   MenuTokoItem(),
        // ],
        children: <Widget>[for (var item in produk) MenuTokoItem(produk: item)],
      ),
    );
  }
}

class MenuTokoItem extends StatelessWidget {
  final produk;
  const MenuTokoItem({Key? key, this.produk}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 145,
          height: 145,
          decoration: BoxDecoration(
              borderRadius: borderRadius1,
              image: DecorationImage(
                  image: NetworkImage('${produk.gambar}'), fit: BoxFit.cover)),
          child: Stack(children: [
            Positioned(
              bottom: 10,
              left: 10,
              child: Row(children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colorBlueEdit,
                        boxShadow: [boxshadow2]),
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colorRedDelete,
                        boxShadow: [boxshadow2]),
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                )
              ]),
            ),
          ]),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5, bottom: 2),
          child: Text(
            '${produk.nama}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        Text(
          'Rp ${produk.harga}',
          style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.w500, color: color1),
        )
      ],
    );
  }
}
