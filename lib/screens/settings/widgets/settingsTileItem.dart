import 'package:credstream/core/colors.dart';
import 'package:credstream/core/constants.dart';
import 'package:credstream/domain/localDB/localdb_crud.dart';
import 'package:credstream/provider/loadingProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsTileItem extends StatelessWidget with ChangeNotifier {
  String title;
  String subtitle;
  int index;
  IconData iconData;
  SettingsTileItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.index,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: deviceDarkThemeFlag ? kdarkListTile : klightListTile,
      child: Consumer<LoadingProvider>(
        builder: (__, value, child) => InkWell(
          onTap: () async {
            if (index == 1) {
            } else if (index == 2) {
            } else if (index == 3) {
              // indexNotifier.value = 0;
              value.startLoading();

              await LocalDBCrud.removeUser();
              value.stopLoading();

              if (context.mounted) {
                Navigator.pushNamedAndRemoveUntil(
                    context, 'main_auth', (route) => false);
              }
            }
          },
          splashColor: kBlue,
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            leading: Icon(
              iconData,
              color: kBlue,
            ),
            title: Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            subtitle: Text(
              subtitle,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontSize: 14, color: kGrey600),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              color: deviceDarkThemeFlag ? kGrey400 : kBlack,
            ),
          ),
        ),
      ),
    );
  }
}
