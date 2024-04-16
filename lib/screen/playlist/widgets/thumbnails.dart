import 'package:flutter/material.dart';

class PlaylistThumbnail extends StatelessWidget {
  final List imageUrls;
  final double size;

  const PlaylistThumbnail({super.key, required this.imageUrls, required this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
        ),
        itemCount: 4,
        itemBuilder: (context, index) {
          if (index >= imageUrls.length) {
            return Container(color: Colors.black,);
          }
          return Image.network(
            imageUrls[index],
            fit: BoxFit.contain,
          );
        },
      ),
    );
  }
}
