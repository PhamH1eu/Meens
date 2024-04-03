
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webtoon/utilities/fonts.dart';
import '../../../riverpod/tab.dart';

class PersonalProfile extends StatelessWidget {
  const PersonalProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return Scaffold(
            backgroundColor: Colors.black87,
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  ref.invalidate(countProvider);
                },
                color: Colors.white,
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            body: Column(
              children: [
                Container(
                  height: 240,
                  decoration: BoxDecoration(
                    // Box decoration takes a gradient
                    gradient: LinearGradient(
                      // Where the linear gradient begins and ends
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      // Add one stop for each color. Stops should increase from 0 to 1
                      stops: const [0.1, 0.3, 0.5, 0.7, 0.9,],
                      colors: [
                        // Colors are easy thanks to Flutter's Colors class.
                        Colors.indigo[800]!,
                        Colors.indigo[700]!,
                        Colors.indigo[600]!,
                        Colors.indigo[400]!,
                        Colors.indigo[200]!,
                      ],
                    ),
                  ),
                  child:  Padding(
                    padding: const EdgeInsets.only(bottom: 0, left: 10),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          child: ClipOval(
                            child: Image.asset('assets/user.jpg'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("ChoHieungu",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Gilroy',
                                      fontWeight: CustomColors.semiBold,
                                      fontSize: 27)),
                              RichText(
                                textAlign: TextAlign.left,
                                text: const TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '1',
                                      style: TextStyle(
                                        color: Colors.white, // Màu trắng
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' following',
                                      style: TextStyle(
                                        color: Colors.grey, // Màu xám
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
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
                          side: const BorderSide(
                              color: Colors
                                  .white), // Thêm border color là màu trắng
                        ),
                        child: const Text(
                          'Edit',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          // Hành động khi nút được nhấn
                        },
                        icon: const Icon(Icons.more_vert),

                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding:  EdgeInsets.only(left:20),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'No recent activity',
                      style: TextStyle(
                          fontWeight: CustomColors.bold,
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Gilroy'),
                    ),
                  ),
                ),
              ],
            ));
      },
    );
  }
}
