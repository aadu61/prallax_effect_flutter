import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallex_effect/screens/image_parallax_effect.dart';
import 'package:parallex_effect/screens/video_parallex_effect.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
        child: Column(

          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(height: statusBarHeight,),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: (){
                Get.to( ()=> const VideoParallaxEffect());
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black)
                ),
                child: Text("Viedo Parallex Slider"),
              ),
            ),
            SizedBox(height: 30,),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: (){
                Get.to( ()=> const ImageParallaxEffect());
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black)
                ),
                child: Text("Image Parallex Slider"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
