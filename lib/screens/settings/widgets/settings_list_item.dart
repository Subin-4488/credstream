import 'package:credstream/domain/localDB/localdb_crud.dart';
import 'package:credstream/screens/main_page/widgets/bottom_navigation_bar.dart';
import 'package:credstream/screens/screen_widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:credstream/core/colors.dart';

class SettingsTileItem extends StatelessWidget {
  String title;
  String subtitle;
  int index;
  IconData iconData;
  bool dark;
  SettingsTileItem({
    required this.title,
    required this.subtitle,
    required this.index,
    required this.iconData,
    required this.dark,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder( 
            borderRadius: BorderRadius.circular(10)  
          ),
      color: dark ? kdarkListTile : klightListTile,
      child: InkWell(
        onTap: () async {
          if (index == 1) {
          } else if (index == 2) {
          } else if (index == 3) {
            await Loading.startLoading(context);
            indexNotifier.value = 0;
            await LocalDBCrud.removeUser();
            if (context.mounted) {
             Loading.stopLoading(context);
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
            color: dark ? kGrey400 : kBlack,
          ),
        ),
      ),
    );
  }
}
