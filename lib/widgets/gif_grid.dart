import 'package:flutter/material.dart';

class GifGrid extends StatelessWidget {
  final List<String> gifs;
  final bool isMoreLoading;
  final ScrollController controller;

  const GifGrid({
    super.key,
    required this.gifs,
    required this.isMoreLoading,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: controller,
      padding: const EdgeInsets.all(10),
      physics: const BouncingScrollPhysics(),
      itemCount: gifs.length + (isMoreLoading ? 4 : 0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (_, index) {
        if (index >= gifs.length) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(14),
            ),
          );
        }

        return ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: FadeInImage(
            placeholder: const AssetImage("assets/images/loading.gif"),
            image: NetworkImage(gifs[index]),
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
