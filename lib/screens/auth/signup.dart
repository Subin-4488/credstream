import 'package:credstream/core/colors.dart';
import 'package:credstream/domain/user/user_api.dart';
import 'package:credstream/models/user.dart';
import 'package:credstream/provider/loading_provider.dart';
import 'package:credstream/screens/auth/widgets/form_widget.dart';
import 'package:credstream/screens/screen_widgets/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Signup extends StatelessWidget {
  Signup({super.key});
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  static ValueNotifier<DateTime> dob = ValueNotifier(DateTime(1920));
  TextEditingController passwordController = TextEditingController();

  @override 
  Widget build(BuildContext context) {
    bool flag = MediaQuery.of(context).platformBrightness == Brightness.dark
        ? true
        : false;
    final size = MediaQuery.of(context).size;
    return Consumer<LoadingProvider>(
      builder: (context, value, child) => value.loading
          ? const Loading() 
          : Scaffold( 
              body: Stack(
              children: [ 
                flag 
                    ? Image.asset(
                        'asset/images/logo/CredStream-logos_white1.png')
                    : Image.asset(
                        'asset/images/logo/CredStream-logos_black1.png'),
                Form(
                  key: formkey,
                  child: Column(
                    children: [
                      const Expanded(
                        child: SizedBox(),
                      ),
                      Container(
                        height: size.height * .50,
                        decoration: BoxDecoration(
                            color: !flag 
                                ? const Color.fromARGB(255, 51, 69, 69)
                                : const Color.fromARGB(196, 18, 99, 153),
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
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
                            const Spacer(),
                            SizedBox(
                              width: size.width * .5,
                              child: ElevatedButton.icon(
                                  onPressed: () async {
                                    if (formkey.currentState!.validate()) {
                                      value.startLoading();
                                      bool response = await UserApi.postUser(
                                          User(
                                              name: nameController.text.trim(),
                                              dateofbirth: DateTime(
                                                dob.value.year,
                                                dob.value.month,
                                                dob.value.day,
                                              ),
                                              email:
                                                  emailController.text.trim(),
                                              password: passwordController.text
                                                  .trim()));
                                      if (context.mounted && response) {
                                        Toast.show(context, "Account created");
                                      } else if (!response) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                backgroundColor: kRed,
                                                content: Text(
                                                  'Account already exist please Login',
                                                )));
                                      }
                                      value.stopLoading();
                                    }
                                  },
                                  icon: const Icon(Icons.login),
                                  label: Text(
                                    "Sign up",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                            fontSize: 16, color: Colors.white),
                                  )),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
                        )),
    );
  }
}
