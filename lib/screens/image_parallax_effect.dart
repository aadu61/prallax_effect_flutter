import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallex_effect/screens/video_parallex_effect.dart';

import '../controller/images_parallax_controller.dart';

class ImageParallaxEffect extends StatelessWidget {
  const ImageParallaxEffect({super.key});

  @override
  Widget build(BuildContext context) {
    var statusBarHeight = MediaQuery.of(context).padding.top;
    return GetX<ImageParallaxConroller>(
      init: ImageParallaxConroller(),
      builder: (controller) {
        return Scaffold(
          body: Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: PageView.builder(
                  controller: controller.pageViewController.value,
                  itemCount: controller.videos.length,
                  onPageChanged: (value) {
                    controller.selectdIndex.value = value;
                    controller.selectdIndex.refresh();
                  },
                  itemBuilder: (context, index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      margin: controller.selectdIndex.value == index
                          ? const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 16)
                          : const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 32),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 6))
                          ]),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Flow(
                          delegate: ParallaxFlowDelegate(
                              scrollable: Scrollable.of(context),
                              listItemContext: context,
                              backgroundImageKey: controller.viedoKey),
                          children: [
                            Image.asset(
                              controller.videos[index],
                              fit: BoxFit.cover,
                              key: controller.viedoKey,
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ),
        );
      },
    );
  }
}
