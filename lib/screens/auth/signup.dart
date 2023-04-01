import 'package:credstream/core/colors.dart';
import 'package:credstream/core/constants.dart';
import 'package:credstream/domain/localDB/localdb.dart';
import 'package:credstream/domain/localDB/localdb_crud.dart';
import 'package:credstream/domain/user/user_api.dart';
import 'package:credstream/models/user.dart';
import 'package:credstream/provider/loadingProvider.dart';
import 'package:credstream/screens/auth/widgets/form_widget.dart';
import 'package:credstream/screens/screen_widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Signup extends StatelessWidget with ChangeNotifier {
  Signup({super.key});
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  static ValueNotifier<DateTime> dob = ValueNotifier(DateTime(1920));
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        deviceDarkThemeFlag
            ? Image.asset(
                'asset/images/logo/CredStream-logos_white1.png',
              )
            : Image.asset(
                'asset/images/logo/CredStream-logos_black1.png',
              ),
        Form(
          key: formkey,
          child: Stack(
            children: [
              Column(
                children: [
                  const Expanded(
                    child: SizedBox(),
                  ),
                  Container(
                    //go for singlechildscrollview
                    height: deviceSize.height * .53,
                    decoration: BoxDecoration(
                        color: !deviceDarkThemeFlag
                            ? const Color.fromARGB(255, 51, 69, 69)
                            : const Color.fromARGB(255, 37, 37, 37),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25))),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          FormTextFormField(
                              hint: "Name",
                              icon: Icons.person,
                              index: 0,
                              controller: nameController),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: ValueListenableBuilder(
                                  valueListenable: Signup.dob,
                                  builder: (context, value, child) =>
                                      DobTextField(),
                                )),
                          ),
                          FormTextFormField(
                              hint: "Email",
                              icon: Icons.email,
                              index: 1,
                              controller: emailController),
                          FormTextFormField(
                              hint: "Password",
                              icon: Icons.password_rounded,
                              index: 2,
                              controller: passwordController),
                          FormTextFormField(
                              hint: "Renter Password",
                              icon: Icons.password_rounded,
                              index: 3,
                              controller: repasswordController,
                              passController: passwordController),
                          SizedBox(
                            width: deviceSize.width * .5,
                            child: Consumer<LoadingProvider>(
                              builder: (context, value, child) =>
                                  ElevatedButton.icon(
                                      onPressed: () async {
                                        if (formkey.currentState!.validate()) {
                                          value.startLoading();

                                          bool response =
                                              await UserApi.signupUser(User(
                                                  name: nameController.text
                                                      .trim(),
                                                  dateofbirth: DateTime(
                                                    dob.value.year,
                                                    dob.value.month,
                                                    dob.value.day,
                                                  ),
                                                  email: emailController.text
                                                      .trim(),
                                                  password: passwordController
                                                      .text
                                                      .trim()));

                                          value.stopLoading();

                                          if (context.mounted && response) {
                                            await Toast.show(
                                                context, "Account created");
                                            LocalDBUser userSave = LocalDBUser(
                                              credentialWatermark: 'null',
                                                email:
                                                    emailController.text.trim(),
                                                name:
                                                    nameController.text.trim());
                                            userSave.loggedin = true;
                                            userSave.key =
                                                await LocalDBCrud.createUser(
                                                    userSave);

                                            if (context.mounted) {
                                              await Navigator.of(context)
                                                  .pushNamedAndRemoveUntil(
                                                      'mainPage',
                                                      (route) => false);
                                            }
                                          } else if (!response) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    backgroundColor: kRed,
                                                    content: Text(
                                                      'Account already exist please Login',
                                                    )));
                                          }
                                        }
                                      },
                                      icon: const Icon(Icons.login),
                                      label: Text(
                                        "Sign up",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                                fontSize: 16,
                                                color: Colors.white),
                                      )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Consumer<LoadingProvider>(
                builder: (context, value, child) {
                  return Visibility(
                    visible: value.loading,
                    child: Container(
                        color: deviceDarkThemeFlag ? kBlack : kWhite,
                        height: deviceSize.height,  
                        width: deviceSize.width,
                        child: const Loading()),
                  );
                },
              )
            ],
          ),
        )
      ],
    ));
  }
}
