import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/consts/list.dart';
import 'package:e_mart/controllers/auth_controller.dart';
import 'package:e_mart/views/auth_screen/login_screen.dart';
import 'package:e_mart/views/profile_screen/components/details_card.dart';
import 'package:e_mart/widgets_common/bg_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());

    return bgWidget(
      child: Scaffold(
        body: SafeArea(
            child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              //edit profile
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: const Align(
                  alignment: Alignment.topRight,
                  child: Icon(
                    Icons.edit,
                    color: whiteColor,
                  ),
                ).onTap(() {}),
              ),

              //user detail
              Row(
                children: [
                  Image.asset(
                    imgProfileMe,
                    width: 100,
                    fit: BoxFit.cover,
                  ).box.roundedFull.clip(Clip.antiAlias).make(),
                  10.widthBox,
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      "Dummy User".text.bold.white.make(),
                      "customer@example.com".text.white.make(),
                    ],
                  )),
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                        color: whiteColor,
                      )),
                      onPressed: () async {
                        await controller.signoutMethod(context);
                        Get.offAll(() => const LoginScreen());
                      },
                      child: logout.text.semiBold.white.make()),
                ],
              ),
              20.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  detailsCard(
                      count: "05",
                      title: "in your cart",
                      width: context.screenWidth / 3.4),
                  detailsCard(
                      count: "65",
                      title: "in your wishlist",
                      width: context.screenWidth / 3.4),
                  detailsCard(
                      count: "20",
                      title: "your order",
                      width: context.screenWidth / 3.4),
                ],
              ),
              30.heightBox,
              //buttons section
              ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) {
                  return const Divider(
                    color: lightGrey,
                  );
                },
                itemCount: profileButtonList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: profileButtonList[index]
                        .text
                        .color(darkFontGrey)
                        .semiBold
                        .make(),
                    leading: Image.asset(
                      profileButtonIcon[index],
                      width: 22,
                    ),
                  );
                },
              )
                  .box
                  .white
                  .rounded
                  .shadowSm
                  .padding(const EdgeInsets.symmetric(horizontal: 16))
                  .make(),
              Expanded(
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        appname.text.color(redColor).make(),
                        " - ".text.make(),
                        appversion.text.make(),
                      ],
                    )),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
