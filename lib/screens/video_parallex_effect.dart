import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../controller/video_parallax_controller.dart';

class VideoParallaxEffect extends StatelessWidget {
  const VideoParallaxEffect({super.key});

  @override
  Widget build(BuildContext context) {
    var statusBarHeight = MediaQuery.of(context).padding.top;
    return GetX<VideoParallaxController>(
      init: VideoParallaxController(),
      builder: (controller) {
        return Scaffold(
          body: Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: PageView.builder(
                  controller: controller.pageViewController.value,
                  itemCount: controller.videos.length,
                  onPageChanged: (value){
                    controller.selectdIndex.value = value;
                  },
                  itemBuilder: (context, index) {
                    return VideoCard(filePath: controller.videos[index],selectedIndex:controller.selectdIndex.value == index);
                  }),
            ),
          ),
        );
      },
    );
  }
}

class VideoCard extends StatefulWidget {
  final String filePath;

  const VideoCard({
    super.key,
    required this.filePath, required  bool selectedIndex,
  });

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  late VideoPlayerController _controller;
  final GlobalKey _viedoKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = VideoPlayerController.asset(widget.filePath);

    _controller
      ..addListener(() {
        setState(() {});
      })
      ..setLooping(true)
      ..initialize().then((value) => setState(() {}))
      ..setVolume(0)
      ..play();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
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
              backgroundImageKey: _viedoKey),
          children: [
            AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(
                _controller,
                key: _viedoKey,
              ),
            ),

            // Image.asset(
            //   widget.filePath,
            //   fit: BoxFit.cover,
            //   key: _viedoKey,
            // )
          ],
        ),
      ),
    );
  }
}

class ParallaxFlowDelegate extends FlowDelegate {
  ParallaxFlowDelegate({
    required this.scrollable,
    required this.listItemContext,
    required this.backgroundImageKey,
  }) : super(repaint: scrollable.position);

  final ScrollableState scrollable;
  final BuildContext listItemContext;
  final GlobalKey backgroundImageKey;

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return BoxConstraints.tightFor(
      width: constraints.maxHeight,
    );
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    // Calculate the position of this list item within the viewport.
    final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
    final listItemBox = listItemContext.findRenderObject() as RenderBox;
    final listItemOffset = listItemBox.localToGlobal(
        listItemBox.size.topCenter(Offset.zero),
        ancestor: scrollableBox);

    // Determine the percent position of this list item within the
    // scrollable area.
    final viewportDimension = scrollable.position.viewportDimension;
    final scrollFraction =
        (listItemOffset.dx / viewportDimension).clamp(0.0, 1.0);

    // Calculate the vertical alignment of the background
    // based on the scroll percent.
    final verticalAlignment = Alignment(scrollFraction * 2 - 1, 0.0);

    // Convert the background alignment into a pixel offset for
    // painting purposes.
    final backgroundSize =
        (backgroundImageKey.currentContext!.findRenderObject() as RenderBox)
            .size;
    final listItemSize = context.size;
    final childRect =
        verticalAlignment.inscribe(backgroundSize, Offset.zero & listItemSize);

    // Paint the background.
    context.paintChild(
      0,
      transform:
          Transform.translate(offset: Offset(childRect.left, 0.0)).transform,
    );
  }

  @override
  bool shouldRepaint(ParallaxFlowDelegate oldDelegate) {
    return scrollable != oldDelegate.scrollable ||
        listItemContext != oldDelegate.listItemContext ||
        backgroundImageKey != oldDelegate.backgroundImageKey;
  }
}
