import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../riverpod/tab.dart';
import '../../riverpod/theme.dart';
import '../../utilities/fonts.dart';

class Sidebar extends ConsumerWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var darkMode = ref.read(darkModeProvider);
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Users').doc(
          FirebaseAuth.instance.currentUser!.email)
          .snapshots(),
      builder: ((context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ));
        }
        String name ="";
        String url = "";
        String email = "";
        try {
          name = snapshot.data!.get("nickName");
          email = snapshot.data!.get("email");
          url = snapshot.data!.get("photoUrl");
        } catch (e) {
          //this is normal, it is laggy a bit when the user is first time
          return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ));
        }
        return Drawer(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            child: ListView(

              padding: EdgeInsets.zero,
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName:  Text(name,

                      style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Gilroy',
                          fontWeight: CustomColors.semiBold)),
                  accountEmail: Text(email,
                      style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Gilroy',
                          fontWeight: CustomColors.regular)),
                  currentAccountPicture: CircleAvatar(
                    child: ClipOval(
                      child: Image.network(url),
                    ),
                  ),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/wallpaper.jpg'),
                        fit: BoxFit.cover),
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
                    ref.read(countProvider.notifier).state = 4;
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
                    ref.read(countProvider.notifier).state = 3;
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(
                    FontAwesomeIcons.radio,
                    color: Theme.of(context).secondaryHeaderColor,
                  ),
                  title: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text('Playlists',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: CustomColors.semiBold,
                          fontFamily: 'Gilroy',
                        )),
                  ),
                  onTap: () {
                    ref.read(countProvider.notifier).state = 5;
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(
                    FontAwesomeIcons.napster,
                    color: Theme.of(context).secondaryHeaderColor,
                  ),
                  title: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text('Recognize Music',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: CustomColors.semiBold,
                          fontFamily: 'Gilroy',
                        )),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/recog');
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
      }),
    );
  }
}
