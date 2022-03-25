import 'package:flutter/material.dart';
import 'package:dahar/global_styles.dart';

class ItemDetail extends StatefulWidget {
  const ItemDetail({Key? key}) : super(key: key);

  @override
  State<ItemDetail> createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(alignment: Alignment.center, children: [
        Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
              height: 420,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://images.unsplash.com/photo-1572656631137-7935297eff55?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80'),
                      fit: BoxFit.cover)),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: borderRadius1,
                        color: Colors.white,
                      ),
                      child: IconButton(
                          color: color1,
                          onPressed: () {},
                          icon: Icon(Icons.arrow_back_ios_rounded)),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: borderRadius1,
                        color: Colors.white,
                      ),
                      child: IconButton(
                          color: color1,
                          onPressed: () {},
                          icon: Icon(Icons.favorite_border_rounded)),
                    )
                  ]),
            )),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.only(left: 25, right: 25, top: 35),
              height: 460,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Kari Spesial',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 24),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: colorStar,
                          ),
                          const Text(
                            '4.2',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          )
                        ],
                      )
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          margin: const EdgeInsets.only(right: 15),
                          decoration: BoxDecoration(
                              borderRadius: borderRadius1, color: color1),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 3),
                              child: const Text(
                                'Warung Bu Supiah',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                            ),
                            const Text('200 m')
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 180,
                    margin: const EdgeInsets.only(top: 15),
                    child: ListView(padding: EdgeInsets.zero, children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        child: const Text(
                          'Description',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ),
                      const Text(
                        '''Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?''',
                        softWrap: true,
                      )
                    ]),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: borderRadius1,
                        color: color1,
                        boxShadow: [boxshadow1]),
                    child: TextButton(
                      child: const Text(
                        'Add to Cart',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(color: color1, width: 3),
                      borderRadius: borderRadius1,
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: borderRadius1,
                                color: color1,
                                boxShadow: [boxshadow1]),
                            child: TextButton(
                              child: const Text(
                                'Buy',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {},
                            ),
                          ),
                          Text(
                            'Rp 20.000',
                            style: TextStyle(
                                color: color1,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          )
                        ]),
                  )
                ],
              ),
            )),
        Positioned(
            top: 290,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: borderRadius1,
                  color: color1,
                  boxShadow: [boxshadow1]),
              child: Row(
                children: [
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        '-',
                        style: TextStyle(color: Colors.white),
                      )),
                  const Text(
                    '1',
                    style: TextStyle(color: Colors.white),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        '+',
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
            ))
      ]),
    );
  }
}
