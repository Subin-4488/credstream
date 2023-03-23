import 'package:credstream/core/apptheme.dart';
import 'package:credstream/core/constants.dart';
import 'package:credstream/domain/localDB/localdb.dart';
import 'package:credstream/provider/LoadingProvider.dart';
import 'package:credstream/screens/auth/login.dart';
import 'package:credstream/screens/auth/signup.dart';
import 'package:credstream/screens/auth/widgets/main_auth.dart';
import 'package:credstream/screens/screen_widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:credstream/screens/main_page/main_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(const Main());
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  bool _loading = true;
  bool _home = false;

  void load() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(LocalDBUserAdapter().typeId)) {
      Hive.registerAdapter(LocalDBUserAdapter());
    }
    Box<LocalDBUser> box = await Hive.openBox<LocalDBUser>("User");
    if (box.values.isNotEmpty && box.values.first.loggedin) {
      _home = true;
    }
    print('Database: ');
    box.values.forEach(
      (element) => print(element.email),
    );
    // await box.clear();
    // print('Cleared');
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    load();
    super.initState();
  } 

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Container(
            color: const Color.fromRGBO(168, 40, 40, 1),
            child: SizedBox(
                child: Image.asset('asset/images/logo/CredStream-1.png')),
          )
        : MultiProvider(
          providers: [
            ChangeNotifierProvider(create:(context) => LoadingProvider(),)
          ],
          child: MaterialApp(
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              debugShowCheckedModeBanner: false,
              routes: {
                "main_auth": (context) => const MainAuth(),
                "mainPage": (context) => MainPage(),
                "login": (context) => Login(),
                "signup": (context) => Signup(),
              },
              initialRoute: _home ? "mainPage" : "main_auth",
            ), 
        );
  }
}
