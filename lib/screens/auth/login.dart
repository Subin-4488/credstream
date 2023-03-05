import 'package:credstream/screens/auth/widgets/form_widget.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {

  Login({super.key});
  final formkey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bool flag = MediaQuery.of(context).platformBrightness == Brightness.dark
        ? true
        : false;
    return Scaffold(
        body: Stack(
      children: [
        flag
            ? Image.asset('asset/images/logo/CredStream-logos_white1.png')
            : Image.asset('asset/images/logo/CredStream-logos_black1.png'),
        Form(
            child: Form(
          key: formkey,
          child: Column(
            children: [
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                    color: !flag
                        ? const Color.fromARGB(255, 51, 69, 69)
                        : const Color.fromARGB(196, 18, 99, 153),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25))),
                height: size.height * .46,
                child: Column(
                  children: [
                    const Spacer(),
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
                    const Expanded(child: SizedBox()),
                    SizedBox(
                      width: size.width * .5,
                      child: ElevatedButton.icon(
                          onPressed: () {
                            if (formkey.currentState!.validate()) {}
                          },
                          icon: const Icon(Icons.login),
                          label: Text(
                            "Log in",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontSize: 16, color: Colors.white),
                          )),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ],
          ),
        ))
      ],
    ));
  }
}