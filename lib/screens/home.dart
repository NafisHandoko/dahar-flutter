import 'package:flutter/material.dart';
import 'package:dahar/global_styles.dart';
import 'package:dahar/components/navbar.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(100), child: DaharAppBar()),
        body: Container(
          // padding: const EdgeInsets.only(right: 30, left: 30),
          color: Colors.white,
          child: ListView(
            children: const [Popular(), Closest()],
          ),
        ),
        bottomNavigationBar: const NavBar());
  }
}

class DaharAppBar extends StatefulWidget {
  const DaharAppBar({Key? key}) : super(key: key);

  @override
  State<DaharAppBar> createState() => _DaharAppBarState();
}

class _DaharAppBarState extends State<DaharAppBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        // color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              // constraints: const BoxConstraints(),
              alignment: Alignment.center,
              icon: const Icon(
                Icons.receipt_outlined,
              ),
              color: color1,
              onPressed: () {
                Navigator.pushNamed(context, '/order_history');
              },
            ),
            Text(
              "Dahar",
              style: TextStyle(
                  color: color1, fontSize: 32, fontWeight: FontWeight.bold),
            ),
            IconButton(
              // constraints: const BoxConstraints(),
              alignment: Alignment.center,
              icon: const Icon(
                Icons.search_rounded,
              ),
              color: color1,
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}

Container _popularItem(String foodImage, String foodTitle, String foodSeller) {
  return Container(
    margin: const EdgeInsets.only(right: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 165,
          height: 145,
          decoration: BoxDecoration(
              borderRadius: borderRadius1,
              image: DecorationImage(
                  image: NetworkImage(foodImage), fit: BoxFit.cover)),
          child: Stack(children: [
            Positioned(
              bottom: 10,
              left: 10,
              child: Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  borderRadius: borderRadius1,
                  color: Colors.white.withOpacity(0.8),
                ),
                child: const Text(
                  'Rp 20.000',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  borderRadius: borderRadius1,
                  color: Colors.white.withOpacity(0.8),
                ),
                child: Row(children: [
                  Icon(
                    Icons.star,
                    color: colorStar,
                  ),
                  const Text(
                    '4.2',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ]),
              ),
            )
          ]),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5, bottom: 2),
          child: Text(
            foodTitle,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        Text(
          foodSeller,
          style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.w500, color: color1),
        )
      ],
    ),
  );
}

class Popular extends StatefulWidget {
  const Popular({Key? key}) : super(key: key);

  @override
  State<Popular> createState() => _PopularState();
}

class _PopularState extends State<Popular> {
  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10, left: 25),
          child: const Text(
            'Popular',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
        ),
        SizedBox(
          height: 194,
          child: ListView(
            // padding: const EdgeInsets.only(left: 25),
            padding: const EdgeInsets.symmetric(horizontal: 25),
            scrollDirection: Axis.horizontal,
            children: [
              // Image.network('https://picsum.photos/250?image=9'),
              _popularItem(
                  'https://images.unsplash.com/photo-1572656631137-7935297eff55?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
                  'Kari Spesial',
                  'Warung Bu Supiah'),
              _popularItem(
                  'https://images.unsplash.com/photo-1572656631137-7935297eff55?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
                  'Kari Spesial',
                  'Warung Bu Supiah'),
              _popularItem(
                  'https://images.unsplash.com/photo-1572656631137-7935297eff55?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
                  'Kari Spesial',
                  'Warung Bu Supiah')
            ],
          ),
        )
      ],
    );
  }
}

Container _closestItem(
    String foodImage, String foodSeller, String foodDistance) {
  return Container(
    margin: const EdgeInsets.only(bottom: 15),
    height: 100,
    decoration: BoxDecoration(
        borderRadius: borderRadius1,
        image:
            DecorationImage(image: NetworkImage(foodImage), fit: BoxFit.cover)),
    child: Stack(children: [
      Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius1,
          color: Colors.black.withOpacity(0.4),
        ),
      ),
      Positioned(
        bottom: 15,
        left: 15,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            margin: const EdgeInsets.only(bottom: 2),
            child: Text(foodSeller,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white)),
          ),
          Text(
            foodDistance,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w600, color: color2),
          )
        ]),
      )
    ]),
  );
}

class Closest extends StatefulWidget {
  const Closest({Key? key}) : super(key: key);

  @override
  State<Closest> createState() => _ClosestState();
}

class _ClosestState extends State<Closest> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 25, right: 25, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: const Text(
              'Closest',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
          ),
          Column(
            children: [
              _closestItem(
                  'https://images.unsplash.com/photo-1572656631137-7935297eff55?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
                  'Warung Bu Supiah',
                  '200 m'),
              _closestItem(
                  'https://images.unsplash.com/photo-1572656631137-7935297eff55?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
                  'Warung Bu Supiah',
                  '200 m'),
              _closestItem(
                  'https://images.unsplash.com/photo-1572656631137-7935297eff55?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
                  'Warung Bu Supiah',
                  '200 m'),
              _closestItem(
                  'https://images.unsplash.com/photo-1572656631137-7935297eff55?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
                  'Warung Bu Supiah',
                  '200 m')
            ],
          )
        ],
      ),
    );
  }
}
