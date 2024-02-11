import 'package:flutter/material.dart';
import 'package:get/get.dart';


class VideoParallaxController extends GetxController{

  Rxn<PageController> pageViewController = Rxn<PageController>();
  RxList<String> videos =  RxList<String>([
    "assets/videos/1.mp4",
    "assets/videos/2.mp4",
    "assets/videos/3.mp4",
    "assets/videos/4.mp4",
    "assets/videos/5.mp4",
    "assets/videos/6.mp4",
    "assets/videos/7.mp4",
    "assets/videos/8.mp4",
  ]);

  // RxList<String> videos =  RxList<String>([
  //   "assets/images/1.jpg",
  //   "assets/images/2.jpg",
  //   "assets/images/3.jpg",
  //   "assets/images/4.jpg",
  //   "assets/images/5.jpg",
  //   "assets/images/6.jpg",
  //   "assets/images/7.jpg",
  //   "assets/images/8.jpg",
  // ]);
  RxInt selectdIndex = RxInt(0);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    pageViewController.value = PageController(
      viewportFraction: 0.8
    );

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageViewController.value?.dispose();
  }

}