import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vender/screens/add_product.dart';
import 'package:vender/screens/home.dart';
import 'package:vender/screens/performance.dart';

import 'controller/navbar_controller.dart';

class HomeNav extends StatelessWidget {
  const HomeNav({Key? key}) : super(key: key);
  static List<Widget> pages = [
    const AddProduct(),
    const HomePage(),
    const PerformancePage(),

    const PerformancePage(),
    const HomePage(),

    // const TrackerScreen(),
    // const DiscoveryScreen(),
    // const HomeScreen(),
    // const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return GetBuilder<Navabar_controller>(
        init: Navabar_controller(),
        initState: (_) {
          Get.put<Navabar_controller>(Navabar_controller()).update_index(0);
        },
        builder: (controller) => Scaffold(
              body: pages.elementAt(controller.index.value),
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: const Color.fromARGB(255, 249, 250, 250),
                type: BottomNavigationBarType.fixed,
                currentIndex: controller.index.value,
                onTap: (value) {
                  controller.update_index(value);
                },
                useLegacyColorScheme: true,
                showUnselectedLabels: true,
                selectedItemColor: const Color(0xff393E46),
                selectedIconTheme:
                    const IconThemeData(color: Color(0xff393E46)),
                selectedLabelStyle: const TextStyle(
                    fontFamily: "Roboto",
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    height: 16 / 12,
                    letterSpacing: 0.5),
                unselectedLabelStyle: const TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  height: 16 / 12,
                  letterSpacing: 0.5,
                ),
                unselectedIconTheme: IconThemeData(
                    color: const Color(0xff393E46).withOpacity(0.4)),
                unselectedItemColor: const Color(0xff393E46).withOpacity(0.4),
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    activeIcon: const Icon(
                      CupertinoIcons.home,
                      color: Color(0xff393E46),
                    ),
                    icon: Icon(
                      CupertinoIcons.home,
                      color: const Color(0xff393E46).withOpacity(0.4),
                    ),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    activeIcon: const Icon(
                      Icons.bar_chart_rounded,
                      color: Color(0xff393E46),
                    ),
                    icon: Icon(
                      Icons.bar_chart_rounded,
                      color: const Color(0xff393E46).withOpacity(0.4),
                    ),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    activeIcon: const Icon(
                      Icons.support_agent_rounded,
                      color: Color(0xff393E46),
                    ),
                    icon: Icon(
                      Icons.support_agent_rounded,
                      color: const Color(0xff393E46).withOpacity(0.4),
                    ),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    activeIcon: const Icon(
                      Icons.search,
                      color: Color(0xff393E46),
                    ),
                    icon: Icon(
                      Icons.search,
                      color: const Color(0xff393E46).withOpacity(0.4),
                    ),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    activeIcon: const Icon(
                      Icons.person_2_rounded,
                      color: Color(0xff393E46),
                    ),
                    icon: Icon(
                      Icons.person_2_rounded,
                      color: const Color(0xff393E46).withOpacity(0.4),
                    ),
                    label: '',
                  ),
                ],
              ),
            ));
  }
}
