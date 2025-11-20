import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/gif_controller.dart';
import '../widgets/search_bar.dart';
import '../widgets/shimmer_grid.dart';
import '../widgets/gif_grid.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final gifController = Get.put(GifController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mind Drops"),
        centerTitle: true,
        elevation: 1,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          GifSearchBar(onChanged: gifController.onSearchChanged),

          const SizedBox(height: 10),

          Expanded(
            child: Obx(() {
              if (gifController.gifsList.isEmpty &&
                  gifController.isLoading.value) {
                return const ShimmerGrid();
              }

              return NotificationListener<ScrollNotification>(
                onNotification: (scroll) {
                  if (scroll.metrics.pixels >=
                      scroll.metrics.maxScrollExtent - 300) {
                    gifController.fetchMore();
                  }
                  return true;
                },
                child: GifGrid(
                  gifs: gifController.gifsList,
                  isMoreLoading: gifController.isMoreLoading.value,
                  controller: gifController.scrollController,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
