import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'dart:typed_data';

import '../../utilities/_utils.dart';

class LoadUniversalWidget extends StatefulWidget {
  const LoadUniversalWidget({
    super.key,
    required this.fileUrl,
    required this.width,
    required this.height,
    this.radius = 0,
    this.imageFit,
    this.autoPlay = false,
    this.visible = true,
    this.margin = EdgeInsets.zero,
  });

  final String fileUrl;
  final double width;
  final double height;
  final double radius;
  final BoxFit? imageFit;
  final bool autoPlay;
  final bool visible;
  final EdgeInsets margin;

  @override
  State<LoadUniversalWidget> createState() => _LoadUniversalWidgetState();
}

class _LoadUniversalWidgetState extends State<LoadUniversalWidget> {
  late VideoPlayerController _controller;
  bool _isVideoInitialized = false;
  Uint8List? _thumbnailBytes;

  bool get _isVideo {
    final lower = widget.fileUrl.toLowerCase();
    return lower.endsWith('.mp4') || lower.endsWith('.mov') ||
        lower.endsWith('.avi') || lower.endsWith('.mkv') || lower.endsWith('.webm');
  }

  @override
  void initState() {
    super.initState();
    if (_isVideo) {
      _generateThumbnail();
      _initializeVideo();
    }
  }

  @override
  void dispose() {
    if (_isVideo) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant LoadUniversalWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_isVideo && widget.autoPlay != oldWidget.autoPlay) {
      if (widget.autoPlay) {
        _controller.play();
      } else {
        _controller.pause(); // 👈 pause when autoPlay becomes false
      }
    }
  }

  Future<void> _generateThumbnail() async {
    final bytes = await VideoThumbnail.thumbnailData(
      video: widget.fileUrl,
      imageFormat: ImageFormat.JPEG,
      timeMs: 5,
      quality: 75,
    );
    if (mounted) {
      setState(() => _thumbnailBytes = bytes);
    }
  }

  Future<void> _initializeVideo() async {
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.fileUrl));
    await _controller.initialize();
    if (mounted) {
      setState(() => _isVideoInitialized = true);
      printDebug(widget.autoPlay, title: 'AUTOPLAY');
      if (widget.autoPlay) _controller.play(); // 👈 auto-play when first loaded
    }
  }

  void _playVideo() {
    if (!_isVideoInitialized) return;
    _controller.play();
    setState(() {}); // Trigger rebuild to show video
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.visible,
      child: Padding(
        padding: widget.margin,
        child: Center(
          child: SizedBox(
            width: widget.width,
            height: widget.height,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(widget.radius),
              child: _isVideo ? _buildVideo() : _buildImage(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVideo() {
    /// If controller is not playing yet → show thumbnail
    if (!_controller.value.isPlaying) {
      if (_thumbnailBytes != null) {
        return GestureDetector(
          onTap: _playVideo,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.memory(
                _thumbnailBytes!,
                width: widget.width,
                height: widget.height,
                fit: BoxFit.cover,
              ),
              const Icon(
                Icons.play_circle_fill,
                size: 64,
                color: Colors.white,
              ),
            ],
          ),
        );
      } else {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    }

    /// Show video player when playing
    if (!_isVideoInitialized) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.white),
      );
    }

    return GestureDetector(
      onTap: () {
        if (_controller.value.isPlaying) {
          _controller.pause();
        } else {
          _controller.play();
        }
        setState(() {});
      },
      child: Container(
        width: widget.width,
        height: widget.height,
        color: Colors.black,
        child: FittedBox(
          fit: BoxFit.contain,
          child: SizedBox(
            width: _controller.value.size.width,
            height: _controller.value.size.height,
            child: VideoPlayer(_controller),
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return CachedNetworkImage(
      fit: widget.imageFit ?? BoxFit.cover,
      imageUrl: widget.fileUrl,
      placeholder: (context, url) => Container(
        color: Colors.grey.shade300,
        child: const Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        color: Colors.grey.shade300,
        child: const Icon(
          Icons.info_outline,
          color: Colors.white,
        ),
      ),
    );
  }
}