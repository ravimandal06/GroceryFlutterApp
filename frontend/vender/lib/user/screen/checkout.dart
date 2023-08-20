import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vender/user/widget/locationEdit.dart';

class CheckOut extends StatefulWidget {
  const CheckOut({Key? key}) : super(key: key);

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
//

  @override
  void initState() {
    // border = OutlineInputBorder(
    //   borderSide: BorderSide(
    //     color: Colors.grey.withOpacity(0.7),
    //     width: 2.0,
    //   ),
    // );
    super.initState();
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //

                SizedBox(
                  height: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                        ),
                      ),
                      SizedBox(
                        child: Row(
                          children: [
                            Container(
                              height: 90,
                              width: 25,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.orange.shade300,
                              ),
                              child: const Center(
                                child: Text("1"),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text("----"),
                            const SizedBox(
                              width: 5,
                            ),
                            Container(
                              height: 90,
                              width: 25,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.grey.shade300,
                              ),
                              child: const Center(
                                child: Text("2"),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text("----"),
                            const SizedBox(
                              width: 5,
                            ),
                            Container(
                              height: 90,
                              width: 25,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white38,
                                  border:
                                      Border.all(color: Colors.grey.shade300)),
                              child: const Center(
                                child: Text("3"),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                //
                // Widgets

                const SizedBox(
                  height: 16,
                ),
                const Text(
                  "Checkout",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff333333)),
                ),

                const SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Payment method",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff333333)),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          // Get.to(() => const CreditCardEdit());
                        });
                      },
                      child: Text(
                        "Edit",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.orange[300]),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  // height: 200,
                  // width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  // child: CreditCardWidget(
                  //   // glassmorphismConfig: Glassmorphism.defaultConfig(),
                  //   cardNumber: GetStorage().read("cardNumber") ?? cardNumber,
                  //   expiryDate: GetStorage().read("expiryDate") ?? expiryDate,
                  //   cardHolderName:
                  //       GetStorage().read("cardHolderName") ?? cardHolderName,
                  //   cvvCode: GetStorage().read("cvvCode") ?? cvvCode,
                  //   bankName: 'Axis Bank',

                  //   frontCardBorder: !useGlassMorphism
                  //       ? Border.all(color: Colors.grey)
                  //       : null,
                  //   backCardBorder: !useGlassMorphism
                  //       ? Border.all(color: Colors.grey)
                  //       : null,
                  //   showBackView: isCvvFocused,
                  //   obscureCardNumber: true,
                  //   obscureCardCvv: true,
                  //   isHolderNameVisible: true,
                  //   cardBgColor: AppColors.cardBgColor,
                  //   // backgroundImage:
                  //   // useBackgroundImage ? 'assets/card_bg.png' : null,
                  //   isSwipeGestureEnabled: true,
                  //   onCreditCardWidgetChange:
                  //       (CreditCardBrand creditCardBrand) {},
                  //   customCardTypeIcons: const <CustomCardTypeIcon>[
                  //     // CustomCardTypeIcon(
                  //     //   cardType: CardType.mastercard,
                  //     // cardImage: Image.asset(
                  //     //   'assets/mastercard.png',
                  //     //   height: 48,
                  //     //   width: 48,
                  //     // ),
                  //     // ),
                  //   ],
                  // ),
                ),

                const SizedBox(
                  height: 26,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Delivery address",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff333333)),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          Get.to(() => const LocationEdit());
                        });
                      },
                      child: Text(
                        "Edit",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.orange[300]),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                const Divider(
                  height: 10,
                  endIndent: 10,
                  color: Colors.black38,
                  thickness: 1,
                ),
                //
                const SizedBox(
                  height: 16,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Home",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        Text(
                          "${GetStorage().read('_address') ?? "Kolkata, West Bengal, India"}",
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: const Color(0xffffffff),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 0.5,
                              blurRadius: 1,
                              offset: const Offset(
                                  0, 1), // changes position of shadow
                            ),
                          ]),
                      child: const Center(
                        child: Icon(Icons.location_on_outlined),
                      ),
                    )
                  ],
                ),

                const SizedBox(
                  height: 200,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 360,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle checkout button press
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Continue to Checkout',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
