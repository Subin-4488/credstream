import 'package:credstream/core/colors.dart';
import 'package:credstream/core/constants.dart';
import 'package:credstream/domain/localDB/localdb.dart';
import 'package:credstream/domain/localDB/localdb_crud.dart';
import 'package:credstream/domain/user/user_api.dart';
import 'package:credstream/models/credential.dart';
import 'package:credstream/models/user.dart';
import 'package:credstream/provider/loadingProvider.dart';
import 'package:credstream/screens/auth/widgets/form_widget.dart';
import 'package:credstream/screens/screen_widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget with ChangeNotifier {
  Login({super.key});
  final formkey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        deviceDarkThemeFlag
            ? Image.asset('asset/images/logo/CredStream-logos_white1.png')
            : Image.asset('asset/images/logo/CredStream-logos_black1.png'),
        Form(
            child: Form(
          key: formkey,
          child: Stack(
            children: [
              Column(
                children: [
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                        color: !deviceDarkThemeFlag
                            ? const Color.fromARGB(255, 39, 39, 39)
                            : const Color.fromARGB(255, 37, 37, 37),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25))),
                    height: deviceSizePortrait.height * .40,
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
                          width: deviceSizePortrait.width * .5,
                          child: Consumer<LoadingProvider>(
                            builder: (context, value, child) =>
                                ElevatedButton.icon(
                                    onPressed: () async {
                                      if (formkey.currentState!.validate()) {
                                        
                                        value.startLoading();
                                        User user = User(
                                            email: emailController.text.trim(),
                                            password:
                                                passwordController.text.trim());

                                        Credential? credential =
                                            await UserApi.loginUser(user);

                                        value.stopLoading();

                                        if (context.mounted &&
                                            credential != null) {
                                          await Toast.show(
                                              context, "Login success");
                                          LocalDBUser userSave = LocalDBUser(
                                              email:
                                                  emailController.text.trim(),
                                              name: credential.name,
                                              credentialWatermark: credential
                                                  .credential
                                                  .toString());
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
                                        } else if (credential == null) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  backgroundColor: kRed,
                                                  content: Text(
                                                    'No account exist! please try again', 
                                                  )));
                                        }
                                      }
                                    },
                                    icon: const Icon(Icons.login),
                                    label: Text(
                                      "Log in",
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
                  return Visibility(
                    visible: value.loading,
                    child: Container(
                        color: deviceDarkThemeFlag ? kBlack : kWhite,
                        height: deviceSizePortrait.height,
                        width: deviceSizePortrait.width,
                        child: const Loading()),
                  );
                },
              )
            ],
          ),
        ))
      ],
    ));
  }
}
