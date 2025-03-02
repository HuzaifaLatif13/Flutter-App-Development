import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/controllers/auth_controller.dart';
import 'package:e_mart/views/home_screen/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../widgets_common/applogo_widget.dart';
import '../../widgets_common/bg_widget.dart';
import '../../widgets_common/custom_textfield.dart';
import '../../widgets_common/our_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isCheck = false;
  var controller = Get.put(AuthController());
  //text controllers
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            applogoWidget(),
            10.heightBox,
            "Join the $appname".text.fontFamily(bold).white.size(18).make(),
            15.heightBox,
            Obx(
              () => Column(
                children: [
                  customTextField(
                      title: name,
                      hint: nameHint,
                      controller: nameController,
                      isPass: false),
                  customTextField(
                      title: email,
                      hint: emailHint,
                      controller: emailController,
                      isPass: false),
                  customTextField(
                      title: password,
                      hint: passwordhint,
                      controller: passwordController,
                      isPass: true),
                  customTextField(
                      title: retypePassword,
                      hint: passwordhint,
                      controller: passwordRetypeController,
                      isPass: true),
                  Row(
                    children: [
                      Checkbox(
                        value: isCheck,
                        onChanged: (newValue) {
                          setState(() {
                            isCheck = newValue!;
                          });
                        },
                        checkColor: redColor,
                      ),
                      5.widthBox,
                      Expanded(
                        child: RichText(
                            text: const TextSpan(children: [
                          TextSpan(
                              text: "I agree to the ",
                              style: TextStyle(
                                  fontFamily: regular, color: fontGrey)),
                          TextSpan(
                              text: termAndCondition,
                              style: TextStyle(
                                  fontFamily: regular, color: redColor)),
                          TextSpan(
                              text: " and ",
                              style: TextStyle(
                                  fontFamily: regular, color: fontGrey)),
                          TextSpan(
                              text: privacyPolicy,
                              style: TextStyle(
                                  fontFamily: regular, color: redColor)),
                        ])),
                      ),
                    ],
                  ),
                  5.heightBox,
                  controller.isloading.value
                      ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(redColor),
                        )
                      : ourButton(
                          color: isCheck == true ? redColor : lightGolden,
                          title: signup,
                          textColor: whiteColor,
                          onPress: () async {
                            controller
                                .isloading(true); // Start loading indicator
                            try {
                              if (!isCheck) {
                                VxToast.show(context, msg: chkBox);
                                return; // Exit early
                              }

                              if (passwordController.text !=
                                  passwordRetypeController.text) {
                                VxToast.show(context, msg: passNotSame);
                                return; // Exit early
                              }

                              // Attempt to sign up the user
                              UserCredential? userCredential =
                                  await controller.signupMethod(
                                context: context,
                                email: emailController.text,
                                password: passwordController.text,
                              );

                              if (userCredential != null) {
                                // Store user data in Firestore
                                await controller.storeUserData(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text,
                                );

                                // Show success message and navigate
                                VxToast.show(context, msg: loggedin);
                                Get.offAll(() => const Home());
                              }
                            } catch (e) {
                              auth.signOut(); // Sign out if any error occurs
                              VxToast.show(context, msg: e.toString());
                            } finally {
                              // Stop loading indicator in all cases
                              controller.isloading(false);
                            }
                          },
                        ).box.width(context.screenWidth - 50).make(),
                  10.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      alreadyAccount.text.color(fontGrey).make(),
                      login.text.color(redColor).make().onTap(() {
                        Get.back();
                      })
                    ],
                  ),
                ],
              )
                  .box
                  .white
                  .rounded
                  .padding(const EdgeInsets.all(16))
                  .width(context.screenWidth - 70)
                  .shadowSm
                  .make(),
            ),
          ],
        ),
      ),
    ));
  }
}
