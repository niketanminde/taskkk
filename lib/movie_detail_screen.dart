import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jd_task/movie_model.dart';
import 'package:video_player/video_player.dart';


class MovieDetailScreen extends StatefulWidget {
  final Movie movie;

  MovieDetailScreen({required this.movie});

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  void _initializeVideoPlayer() {
    _videoPlayerController = VideoPlayerController.network(
      'https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_5mb.mp4',
    );

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoInitialize: true,
      looping: false,
      allowFullScreen: true,
      allowMuting: false,
      showControlsOnInitialize: false,
      autoPlay: true,
      fullScreenByDefault: true,
      deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
    );
  }

  void _playTrailer() {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        child: Chewie(
          controller: _chewieController,
        ),
      ),
    ).then((_) {
      _chewieController.pause();
      _chewieController.seekTo(Duration.zero);
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: 'https://image.tmdb.org/t/p/w500${widget.movie.backdropPath}',
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.movie.overview,
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            ElevatedButton(
              onPressed: _playTrailer,
              child: Text('Watch Trailer'),
            ),
          ],
        ),
      ),
    );
  }
}
