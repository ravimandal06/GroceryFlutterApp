import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vender/user/screen/productDetailPage.dart';

class ReviewProductPage extends StatefulWidget {
  const ReviewProductPage({Key? key}) : super(key: key);

  @override
  State<ReviewProductPage> createState() => _ReviewProductPageState();
}

class _ReviewProductPageState extends State<ReviewProductPage> {
  List<double> ratings = [4.5, 3.0, 3.5, 5.0, 4.0];
  //
  final List<double> percentages = [75.0, 40.0, 90.0, 20.0, 60.0];
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const PageScrollPhysics(),
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                height: 55,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            Get.back();
                          });
                        },
                        child: const Icon(Icons.arrow_back_ios_new_rounded)),
                    const Text(
                      "Review Product",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Color(0xffFECC4C),
                          ),
                          Text(
                            "4.6",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              // Divider(
              //   color: Colors.grey[350],
              //   thickness: 0.5,
              //   // width: 15,
              // ),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                height: 107,
                child: Row(
                  children: [
                    SizedBox(
                      height: 62,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: const TextSpan(children: [
                              TextSpan(
                                  text: "4.6",
                                  style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  )),
                              TextSpan(
                                  text: "/5",
                                  style: TextStyle(color: Colors.grey))
                            ]),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          const Text(
                            "100 reviews",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                    VerticalDivider(
                      color: Colors.grey[350],
                      thickness: 0.5,
                      width: 15,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                      width: 90,
                      height: 106,
                      child: Column(
                        children: [
                          //
                          for (int i = 0; i < ratings.length; i++)
                            StarRating(
                              rating: ratings[i], // Set the rating value here.
                              size: 18.0, // Adjust the size of the stars.
                              color: const Color(
                                  0xffFECC4C), // Adjust the star color.
                            ),

                          //
                        ],
                      ),
                    ),
                    // SizedBox(
                    //   height: 108,
                    //   width: 97,
                    //   child: Column(
                    //     children: [
                    //       for (int i = 0; i < percentages.length; i++)
                    //         LinearProgressIndicator(
                    //           value: percentages[i] / 100,
                    //           valueColor: const AlwaysStoppedAnimation<Color>(
                    //               Colors.blue),
                    //         ),
                    //       SizedBox(
                    //         height: 15,
                    //       ),
                    //     ],
                    //   ),
                    // )
                    Padding(
                      padding: const EdgeInsets.only(left: 40.0),
                      child: SizedBox(
                        height: 110,
                        width: 97,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            for (int i = 0; i < percentages.length; i++)
                              Text(
                                '${percentages[i]}%',
                                style: const TextStyle(fontSize: 12),
                              ),
                            const SizedBox(
                              height: 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //
              SizedBox(
                child: Column(
                  children: [
                    //

                    for (int i = 0; i < 10; i++) const ReviewList(),
                    //
                  ],
                ),
              ),

              //
            ],
          ),
        )),
      ),
    );
  }
}

class ReviewList extends StatelessWidget {
  const ReviewList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      // height: 45,
      width: 325,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          // Container(
          //   height: 50,
          //   width: 50,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(100),
          //     color: const Color(0xffFECC4C),
          //   ),
          // )
          CircleAvatar(),
          SizedBox(
            width: 16,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Yelena Belova",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Text(
                      "2 Minggu yang lalu",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              StarRating(
                rating: 4.5, // Set the rating value here.
                size: 18.0, // Adjust the size of the stars.
                color: Color(
                  0xffFECC4C,
                ), // Adjust the star color.
              ),
              Row(
                children: [
                  Text(
                    "Lorem ipsum dolor sit amet, consectetur\nadipiscing elit, sed do eiusmod tempor\nincididunt ut labore et dolore magna aliqua.",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              //

              //
              //
            ],
          ),
        ],
      ),
    );
  }
}
