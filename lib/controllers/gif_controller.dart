import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/git_api_service.dart';

class GifController extends GetxController {
  final gifsList = <String>[].obs;
  final isLoading = false.obs;
  final isMoreLoading = false.obs;
  final searchQuery = "".obs;

  Timer? _debounce;
  int offset = 0;
  final limit = 25;

  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    fetchTrending();
  }

  void onSearchChanged(String query) {
    searchQuery.value = query;

    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      offset = 0;
      gifsList.clear();
      if (query.isEmpty) {
        fetchTrending();
      } else {
        fetchSearch(query);
      }
    });
  }

  Future<void> fetchTrending() async {
    isLoading.value = true;
    final results = await GifApiService.getTrending(offset, limit);

    if (results != null) gifsList.addAll(results);

    isLoading.value = false;
  }

  Future<void> fetchSearch(String query) async {
    isLoading.value = true;
    final results = await GifApiService.searchGifs(query, offset, limit);

    if (results != null) gifsList.addAll(results);

    isLoading.value = false;
  }

  void fetchMore() async {
    if (isMoreLoading.value) return;

    isMoreLoading.value = true;
    offset += limit;

    final results = searchQuery.value.isEmpty
        ? await GifApiService.getTrending(offset, limit)
        : await GifApiService.searchGifs(searchQuery.value, offset, limit);

    if (results != null) gifsList.addAll(results);

    isMoreLoading.value = false;
  }
}
