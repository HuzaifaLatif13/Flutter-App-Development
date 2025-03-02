import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/controllers/home_controller.dart';
import 'package:e_mart/views/cart_screen/cart_screen.dart';
import 'package:e_mart/views/category_screen/category_screen.dart';
import 'package:e_mart/views/home_screen/Home_Screen.dart';
import 'package:e_mart/views/profile_screen/profile_screen.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(HomeController());

    var navBarItem = [
      BottomNavigationBarItem(icon: Image.asset(icHome, width: 26,), label: home),
      BottomNavigationBarItem(icon: Image.asset(icCategories, width: 26,), label: categories),
      BottomNavigationBarItem(icon: Image.asset(icCart, width: 26,), label: cart),
      BottomNavigationBarItem(icon: Image.asset(icProfile, width: 26,), label: account),
    ];

    var navBody = [
      HomeScreen(),
      CategoryScreen(),
      CartScreen(),
      ProfileScreen(),
    ];

    return Scaffold(
      body: Obx(()=> navBody.elementAt(controller.currentNavIndex.value)),
      bottomNavigationBar: Obx(()=> BottomNavigationBar(items: navBarItem,
        currentIndex: controller.currentNavIndex.value,
        backgroundColor: whiteColor,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: redColor,
          selectedLabelStyle: const TextStyle(fontFamily: semibold),
        onTap: (value)
        {
          controller.currentNavIndex.value = value;
        },
        ),
      ),
    );
  }
}
