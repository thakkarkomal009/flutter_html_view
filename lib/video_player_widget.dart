import 'package:flutter/material.dart';
import 'package:pod_player/pod_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget(
      {Key? key,
        required this.videoUrl,
        required this.videoType,
        this.thumbnailUrl})
      : super(key: key);
  final String videoUrl;
  final String videoType;
  final String? thumbnailUrl;

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late final PodPlayerController controller;

  @override
  void initState() {
    controller = PodPlayerController(
        playVideoFrom: widget.videoType == 'youtube'
            ? PlayVideoFrom.youtube(widget.videoUrl)
            : PlayVideoFrom.network(widget.videoUrl),
        podPlayerConfig:
        PodPlayerConfig(autoPlay: true, videoQualityPriority: [720, 360]))
      ..initialise();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: PodVideoPlayer(
        controller: controller,
        alwaysShowProgressBar: true,
        videoThumbnail: DecorationImage(
          image: widget.thumbnailUrl != null
              ? NetworkImage(widget.thumbnailUrl!)
              : const AssetImage('assets/images/default_thumbnail.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
