import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> middleNavList = [
    'Ordered',
    'Packed',
    'Delivered',
    'Completed',
    'More'
  ];

  int selectedIndex = 0;

  final double progress = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 46,
                    width: 360,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Welcome Back'),
                            Text(
                              "Sam Sepual",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            )
                          ],
                        ),
                        Icon(Icons.notifications)
                      ],
                    ),
                  ),

                  //

                  const SizedBox(
                    height: 16,
                  ),

                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 360,
                    height: 200,
                    child: ListView.builder(
                      clipBehavior: Clip.none,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            padding: const EdgeInsets.all(16.0),
                            width: 240,
                            height: 170,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Colors.black12.withOpacity(0.03)),
                                boxShadow: [
                                  BoxShadow(
                                      color: const Color(0xff0C1A30)
                                          .withOpacity(0.04),
                                      spreadRadius: 1,
                                      blurRadius: 7,
                                      offset: const Offset(0, 7))
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Current Balance',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff0C1A30)),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          '\$1.000.000',
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black),
                                        ),
                                        RichText(
                                            text: TextSpan(children: [
                                          TextSpan(
                                              text: '+ 1,502,00',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.green[400])),
                                          const TextSpan(
                                              text: ' Than Last Month',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black26)),
                                        ])),
                                      ],
                                    ),
                                    Container(
                                      width: 70,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.green[400]),
                                      child: const Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '+0.98%',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white),
                                            ),
                                            Icon(
                                              Icons.arrow_upward,
                                              color: Colors.white,
                                              size: 12,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: 5,
                    ),
                  ),

                  //
                  const SizedBox(
                    height: 16,
                  ),
                  //
                  Container(
                    width: MediaQuery.sizeOf(context).width * 360,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white.withOpacity(0.03)),
                      boxShadow: [
                        BoxShadow(
                            color: const Color.fromARGB(255, 180, 182, 184)
                                .withOpacity(0.04),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: const Offset(0, 7))
                      ],
                    ),
                    child: ListView.builder(
                      itemCount: middleNavList.length,
                      clipBehavior: Clip.none,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.all(4),
                      itemBuilder: (context, index) {
                        return Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = index;
                                    });
                                  },
                                  child: SizedBox(
                                    height: 60,
                                    width: 60,
                                    child: CircleAvatar(
                                      backgroundColor: index == selectedIndex
                                          ? const Color(0xff0C1A30)
                                          : Colors.white,
                                      child: Icon(
                                        Icons.wallet_giftcard_rounded,
                                        color: index == selectedIndex
                                            ? Colors.white
                                            : const Color(0xff0C1A30),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                middleNavList[index],
                                style: const TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  //
                  const SizedBox(
                    height: 16,
                  ),
                  //
                  const Ordered(),

                  //
                  const SizedBox(
                    height: 16,
                  ),
                  //
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 360,
                    child: ListView.builder(
                      itemCount: 8,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 330,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Colors.black.withOpacity(0.03)),
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      const Color.fromARGB(255, 180, 182, 184)
                                          .withOpacity(0.04),
                                  spreadRadius: 1,
                                  blurRadius: 7,
                                  offset: const Offset(0, 7))
                            ],
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 70,
                                height: 70,
                                child: Icon(
                                  Icons.wallet_giftcard_rounded,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                width: 250,
                                height: 80,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Starbucks Coffee",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(3.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Icon(
                                              Icons.person_pin_circle_rounded,
                                              color: Colors.black,
                                            ),
                                            Text(
                                              "● Ongoing",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color.fromARGB(
                                                      255, 235, 201, 99)),
                                            ),
                                            Text(
                                              "10%",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );

                        //
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Ordered extends StatelessWidget {
  const Ordered({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Recent Orders",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),

        //
        const SizedBox(
          height: 16,
        ),
        //
        SizedBox(
          width: MediaQuery.sizeOf(context).width * 360,
          child: ListView.builder(
            itemCount: 8,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return Container(
                width: 330,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black.withOpacity(0.03)),
                  boxShadow: [
                    BoxShadow(
                        color: const Color.fromARGB(255, 180, 182, 184)
                            .withOpacity(0.04),
                        spreadRadius: 1,
                        blurRadius: 7,
                        offset: const Offset(0, 7))
                  ],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 70,
                      height: 70,
                      child: Icon(
                        Icons.wallet_giftcard_rounded,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: 250,
                      height: 80,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Starbucks Coffee",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                            Padding(
                              padding: EdgeInsets.all(3.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.person_pin_circle_rounded,
                                    color: Colors.black,
                                  ),
                                  Text(
                                    "● Ongoing",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            Color.fromARGB(255, 235, 201, 99)),
                                  ),
                                  Text(
                                    "10%",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );

              //
            },
          ),
        ),
      ],
    );
  }
}
