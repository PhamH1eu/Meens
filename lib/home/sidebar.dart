import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../riverpod/tab.dart';
import '../riverpod/theme.dart';
import '../utilities/fonts.dart';

class Sidebar extends ConsumerWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var darkMode = ref.read(darkModeProvider);
    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: const Text("Wolhaiksong",
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Gilroy',
                  fontWeight: CustomColors.semiBold)),
          accountEmail: const Text("deptraicojsai@gmail.com",
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Gilroy',
                  fontWeight: CustomColors.regular)),
          currentAccountPicture: CircleAvatar(
            child: ClipOval(
              child: Image.asset('assets/user.jpg'),
            ),
          ),
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/wallpaper.jpg'), fit: BoxFit.cover),
          ),
        ),
        ListTile(
          leading: Icon(
            FontAwesomeIcons.user,
            color: Theme.of(context).secondaryHeaderColor,
          ),
          title: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text('Profile',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: CustomColors.semiBold,
                  fontFamily: 'Gilroy',
                )),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(
            FontAwesomeIcons.heart,
            color: Theme.of(context).secondaryHeaderColor,
          ),
          title: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text('Liked Songs',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: CustomColors.semiBold,
                  fontFamily: 'Gilroy',
                )),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(
            FontAwesomeIcons.earthAsia,
            color: Theme.of(context).secondaryHeaderColor,
          ),
          title: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text('Language',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: CustomColors.semiBold,
                  fontFamily: 'Gilroy',
                )),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(
            FontAwesomeIcons.message,
            color: Theme.of(context).secondaryHeaderColor,
          ),
          title: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text('Contact us',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: CustomColors.semiBold,
                  fontFamily: 'Gilroy',
                )),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(
            FontAwesomeIcons.lightbulb,
            color: Theme.of(context).secondaryHeaderColor,
          ),
          title: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text('FAQs',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: CustomColors.semiBold,
                  fontFamily: 'Gilroy',
                )),
          ),
          onTap: () {
            ref.read(countProvider.notifier).state = 1;
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(
            FontAwesomeIcons.gear,
            color: Theme.of(context).secondaryHeaderColor,
          ),
          title: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text('Settings',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: CustomColors.semiBold,
                  fontFamily: 'Gilroy',
                )),
          ),
          onTap: () {
            ref.read(countProvider.notifier).state = 2;
            Navigator.pop(context);
          },
        ),
        ListTile(
            leading: Icon(
              darkMode ? FontAwesomeIcons.sun : FontAwesomeIcons.moon,
              color: Theme.of(context).secondaryHeaderColor,
            ),
            title: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(darkMode ? "Light Mode" : "Dark Mode",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: CustomColors.semiBold,
                    fontFamily: 'Gilroy',
                  )),
            ),
            onTap: () {
              ref.read(darkModeProvider.notifier).toggle();
            }),
      ],
    ));
  }
}
