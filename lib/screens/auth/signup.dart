import 'package:credstream/core/colors.dart';
import 'package:credstream/core/values.dart';
import 'package:credstream/domain/localDB/localdb.dart';
import 'package:credstream/domain/localDB/localdb_crud.dart';
import 'package:credstream/domain/user/user_api.dart';
import 'package:credstream/models/user.dart';
import 'package:credstream/provider/LoadingProvider.dart';
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
    bool flag = MediaQuery.of(context).platformBrightness == Brightness.dark
        ? true
        : false;
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: [
        flag
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
                    height: size.height * .6, 
                    decoration: BoxDecoration(
                        color: !flag
                            ? const Color.fromARGB(255, 51, 69, 69)
                            : const Color.fromARGB(255, 37, 37, 37),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25))),
                    child: Column(
                      children: [
                        const Spacer(),
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
                            passrecheck: passwordController.text),
                        const Spacer(),
                        SizedBox(
                          width: size.width * .5,
                          child: Consumer<LoadingProvider>(
                            builder: (context, value, child) =>
                                ElevatedButton.icon(
                                    onPressed: () async {
                                      if (formkey.currentState!.validate()) {
                                        value.startLoading();

                                        bool response =
                                            await UserApi.signupUser(User(
                                                name:
                                                    nameController.text.trim(),
                                                dateofbirth: DateTime(
                                                  dob.value.year,
                                                  dob.value.month,
                                                  dob.value.day,
                                                ),
                                                email:
                                                    emailController.text.trim(),
                                                password: passwordController
                                                    .text
                                                    .trim()));

                                        value.stopLoading();

                                        if (context.mounted && response) {
                                          await Toast.show(
                                              context, "Account created");
                                          LocalDBUser userSave = LocalDBUser(
                                              email:
                                                  emailController.text.trim(),
                                              name: nameController.text.trim());
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
                        const Spacer(),
                      ],
                    ),
                  ),
                ],
              ),
              Consumer<LoadingProvider>(
                builder: (context, value, child) {
                  print("Inside loading builder: ${value.loading}");
                  return Visibility(
                    visible: value.loading,
                    child: Container(
                        color: flag ? kBlack : kWhite,
                        height: size.height,
                        width: size.width,
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
