import 'package:credstream/core/colors.dart';
import 'package:credstream/core/constants.dart';
import 'package:credstream/domain/localDB/localdb_crud.dart';
import 'package:credstream/screens/screen_widgets/main_title.dart';
import 'package:credstream/screens/settings/widgets/settingsTileItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const MainTitle(title: "Settings"),
          kHeight,
          Container(
            width: deviceSize.width,
            height: 120,
            decoration: BoxDecoration(
                color: kBlue, borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: deviceSize.height * .11,
                  width: deviceSize.width * .25,
                  decoration: BoxDecoration(
                      color: kWhite, borderRadius: BorderRadius.circular(20)),
                  child: IconButton(
                    icon: const Icon(
                      CupertinoIcons.person_add,
                      size: 40,
                      color: kBlack,
                    ),
                    onPressed: () {},
                    color: deviceDarkThemeFlag ? kWhite : kBlack,
                  ),
                ),
                kWidth20,
                Text(
                  LocalDBCrud.currentUser().name.toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 25, color: kBlack),
                )
              ],
            ),
          ),
          kHeight40,
          SettingsTileItem(
            title: "Privacy",
            subtitle: "learn privacy policies of credstream",
            index: 1,
            iconData: Icons.privacy_tip_outlined,
          ),
          SettingsTileItem(
            title: "About",
            subtitle: "learn more about credstream",
            index: 2,
            iconData: Icons.info_outline_rounded,
          ),
          kHeight40,
          const MainTitle(title: "Account"),
          kHeight5,
          SettingsTileItem(
            title: "Sign Out",
            subtitle: "",
            index: 3,
            iconData: Icons.logout,
          ),
        ],
      ),
    );
  }
}


