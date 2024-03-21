import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:webtoon/faqs/faq_screen.dart';
import 'package:webtoon/home/homeui.dart';
import 'package:webtoon/likedsong/likedsong.dart';
import 'package:webtoon/miniplayer/mini_player.dart';
import 'package:webtoon/profile/personal/profileOfPersonal.dart';

import 'home/sidebar.dart';
import 'riverpod/tab.dart';
import 'setting/setting_screen.dart';

Set<Widget> _pages = {
  const HomeUI(),
  const FAQ(),
  const Setting(),
  const LikedSong(),
  const PersonalProfile()
};

class Layout extends ConsumerStatefulWidget {
  const Layout({super.key});

  @override
  LayoutState createState() => LayoutState();
}

class LayoutState extends ConsumerState<Layout> {
  bool isHome = true;

  @override
  Widget build(BuildContext context) {
    final tab = ref.watch(countProvider);
    ref.listen(countProvider, (previous, next) {
      if (next == 0) {
        isHome = true;
      } else {
        isHome = false;
      }
    });

    return Scaffold(
      drawer: const Sidebar(),
      appBar: isHome
          ? AppBar(
              leading: Builder(builder: (context) {
                return IconButton(
                  icon: const Icon(FontAwesomeIcons.bars),
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              }),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: IconButton(
                    icon: const Icon(FontAwesomeIcons.magnifyingGlass),
                    color: Theme.of(context).primaryColor,
                    onPressed: () {},
                  ),
                ),
              ],
              backgroundColor: Colors.transparent,
            )
          : null,
      body: Stack(children: <Widget>[
        _pages.elementAt(tab),
        const MiniPlayer(),
      ]),
    );
  }
}
