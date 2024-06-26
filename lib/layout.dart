import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:webtoon/screen/faqs/faq_screen.dart';
import 'package:webtoon/screen/home/homeui.dart';
import 'package:webtoon/screen/likedsong/likedsong.dart';
import 'package:webtoon/screen/miniplayer/mini_player.dart';
import 'package:webtoon/screen/playlist/playlist.dart';
import 'package:webtoon/screen/profile/personal/profileOfPersonal.dart';
import 'package:webtoon/screen/searchEngine/search.dart';

import 'screen/home/sidebar.dart';
import 'riverpod/tab.dart';
import 'screen/setting/setting_screen.dart';

Set<Widget> _pages = {
  const HomeUI(),
  const FAQ(),
  const Setting(),
  const LikedSong(),
  const PersonalProfile(),
  const Playlist(),
};

class Layout extends ConsumerStatefulWidget {
  const Layout({super.key});

  @override
  LayoutState createState() => LayoutState();
}

class LayoutState extends ConsumerState<Layout> {
  bool isHome = true;

  void _openSearchScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const SearchScreen()),
    );
  }

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
                    onPressed: () {
                      _openSearchScreen(context);
                    },
                  ),
                ),
              ],
              backgroundColor: Colors.transparent,
            )
          : null,
      body: Stack(children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 70),
          child: _pages.elementAt(tab),
        ),
        const MiniPlayer(),
      ]),
    );
  }
}
