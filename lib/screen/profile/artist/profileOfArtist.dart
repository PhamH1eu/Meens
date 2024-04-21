// ignore_for_file: file_names




import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webtoon/riverpod/firebase_provider.dart';
import 'package:webtoon/screen/profile/artist/songofartist/songofartist.dart';


import 'package:webtoon/utilities/fonts.dart';

import '../../../firebase/cloud_store/store.dart';

class ArtistProfile extends ConsumerWidget {
  const ArtistProfile({super.key, required this.artistName});

  final String artistName;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final artist = ref.watch(artistSongsProvider(artistName));

    return FutureBuilder(
      future: Storage.getArtistUrl(Storage.validateString(artistName)),
      builder: ((context, snapshot) {
        if (!snapshot.hasData) {
          print ("aaaaaaaaaaaaaaa");
          return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ));
        }
        String artistImage = "";
        try {
          artistImage = snapshot.data!.toString();
        } catch (e) {
          //this is normal, it is laggy a bit when the user is first time
          return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ));
        }
        return Consumer(
          builder: (context, ref, child) {
            return Scaffold(
                extendBodyBehindAppBar: true,
                appBar: AppBar(
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                ),
                body: Column(
                  children: [
                    Container(
                      height: 240,
                      decoration:  BoxDecoration(
                        image: DecorationImage(
                          image:  NetworkImage(artistImage)  as ImageProvider , // Replace with your actual image path
                          fit: BoxFit.cover,
                        ),
                      ),
                      child:  Padding(
                        padding: const EdgeInsets.only(bottom: 0, left: 10),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            artistName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 50,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0, left: 10.0),
                      child: Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              // Hành động khi nút được nhấn
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              side:  BorderSide(
                                  color: Theme.of(context).primaryColor), // Thêm border color là màu trắng
                            ),
                            child: Text(
                              'Follow',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                          const Spacer(),
                          RawMaterialButton(
                            onPressed: () {
                              // Hành động khi nút được nhấn
                            },
                            elevation: 0.0,
                            fillColor: Colors.green,
                            shape: const CircleBorder(),
                            constraints: const BoxConstraints.tightFor(
                              width: 40.0,
                              height: 40.0,
                            ),
                            child:  Icon(
                              Icons.play_arrow,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left:20),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'All song',
                          style: TextStyle(
                              fontWeight: CustomColors.extraBold,
                              color: Theme.of(context).primaryColor,
                              fontSize: 20,
                              fontFamily: 'Gilroy'),
                        ),
                      ),
                    ),
                    artist.when(data: (artistSongs) {
                      return Flexible(
                        child: ListView.builder(
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.vertical,
                            itemCount: artistSongs.length,
                            itemBuilder: (context, index) =>
                                SongOfArtist(song: artistSongs[index])),
                      );
                    },
                      loading: () => Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor,
                          )),
                      error: (error, stack) => Text('Error: $error'),
                    ),

                  ],
                ));
          },
        );
      }),
    );



  }
}
