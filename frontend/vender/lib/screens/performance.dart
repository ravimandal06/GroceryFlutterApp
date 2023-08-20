import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../controller/monthlyDetailExpense.dart';
import '../controller/order_controller.dart';

class PerformancePage extends StatefulWidget {
  const PerformancePage({Key? key}) : super(key: key);

  @override
  State<PerformancePage> createState() => _PerformancePageState();
}

class _PerformancePageState extends State<PerformancePage> {
  int selectedIndex = 0;
  int selectedCategory = 0;

  final List<MonthlyDetails> boxMonthlyDetails = [
    MonthlyDetails(
        icon: Icons.wallet_rounded,
        heading: "Total Income",
        value: "\$ 27.837,00"),
    MonthlyDetails(
        icon: Icons.shopping_cart_outlined,
        heading: "Product Sales",
        value: "1.034"),
    MonthlyDetails(
        icon: Icons.shopping_bag_outlined,
        heading: "Total Stock",
        value: "2.045"),
  ];

  List<String> categoryTab_ = [
    'Top Sales',
    'Top Wishlist',
    'Top View',
    'Top Review'
  ];
  final List<Order> salesCategory = [
    Order(productName: "Product A", status: "304 Transaction", progress: "34 Reviews"),
    Order(productName: "Product B", status: "302 Transaction", progress: "20 Reviews"),
    Order(productName: "Product C", status: "200 Transaction", progress: "22 Reviews"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 320,
                height: 40,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.arrow_back_ios_new_rounded),
                    Text(
                      "Performance",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff0C1A30),
                      ),
                    ),
                    Icon(Icons.more_horiz_rounded),
                  ],
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              SizedBox(
                width: 320,
                height: 55,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Cashflow Analysis",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff9295A3),
                          ),
                        ),
                        Text("\$ 27.235,00",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff0C1A30),
                            )),
                      ],
                    ),
                    SizedBox(
                      child: Row(
                        children: [
                          const Text("Period : "),
                          Container(
                            width: 95,
                            height: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.black.withOpacity(0.1),
                              ),
                            ),
                            child: const Center(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("Monthly"),
                                Icon(Icons.arrow_drop_down)
                              ],
                            )),
                          )
                        ],
                      ),
                    ),

                    //
                  ],
                ),
              ),

              //end sizebox
              const SizedBox(
                height: 16.0,
              ),

              Container(
                width: 320,
                height: 200,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black12),
                    borderRadius: BorderRadius.circular(20)),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 360,
                height: 130,
                child: ListView.builder(
                    itemCount: 3,
                    clipBehavior: Clip.none,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final boxMonthlyDetail = boxMonthlyDetails[index];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Container(
                            width: 140,
                            height: 130,
                            decoration: BoxDecoration(
                              color: index == selectedIndex
                                  ? Colors.green[400]
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: index == selectedIndex
                                      ? Colors.green[400]!
                                      : Colors.black.withOpacity(0.1)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  //
                                  Icon(
                                    boxMonthlyDetail.icon,
                                    color: index == selectedIndex
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                  SizedBox(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          boxMonthlyDetail.heading,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: index == selectedIndex
                                                ? const Color.fromARGB(
                                                    144, 238, 238, 238)
                                                : Colors.black.withOpacity(0.5),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          boxMonthlyDetail.value,
                                          style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w500,
                                            color: index == selectedIndex
                                                ? const Color(0xffeeeeee)
                                                : const Color(0xff0C1A30),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              //end sizebox
              const SizedBox(
                height: 16.0,
              ),
              const Text('Category',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff0C1A30),
                  )),

              const SizedBox(
                height: 16,
              ),

              SizedBox(
                width: MediaQuery.sizeOf(context).width * 360,
                height: 50,
                child: ListView.builder(
                    clipBehavior: Clip.none,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: categoryTab_.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCategory = index;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            width: 100,
                            height: 70,
                            decoration: BoxDecoration(
                              color: index == selectedCategory
                                  ? const Color(0xff0C1A30)
                                  : const Color(0xffeeeeee),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.black.withOpacity(0.1),
                              ),
                            ),
                            child: Center(
                                child: Text(
                              categoryTab_[index],
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: index == selectedCategory
                                    ? const Color(0xffeeeeee)
                                    : const Color(0xff0C1A30),
                              ),
                            )),
                          ),
                        ),
                      );
                    }),
              ),
              SizedBox(height: 16.0,),

              if(selectedCategory == 0)...{
               SizedBox(
                  width: MediaQuery.sizeOf(context).width * 360,
                  child: ListView.builder(
                    itemCount: salesCategory.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      final order = salesCategory[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Container(
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(
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
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        order.productName,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            
                                            Text(
                                              order.status,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color.fromARGB(185, 71, 71, 71)),
                                            ),
                                            Text(
                                              order.progress,
                                              style: const TextStyle(
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
                        ),
                      );

                      //
                    },
                  ),
                ),
      
              }
            ],
          ),
        )),
      ),
    );
  }
}
