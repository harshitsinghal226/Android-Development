import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

enum AudioSourceOptions { Network, Asset }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    _setupAudioPlayer(AudioSourceOptions.Network);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Audio Player App')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              _sourceSelect(),
              _progressBar(),
              Row(children: [_controlButtons(), _playbackControlButton()]),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _setupAudioPlayer(AudioSourceOptions option) async {
    _player.playbackEventStream.listen(
      (event) {},
      onError: (Object e, StackTrace stackTrace) {
        // print('A stream error occurred: $e');
      },
    );

    try {
      if (option == AudioSourceOptions.Network) {
        await _player.setAudioSource(
          AudioSource.uri(
            Uri.parse(
              'https://commondatastorage.googleapis.com/codeskulptor-demos/DDR_assets/Kangaroo_MusiQue_-_The_Neverwritten_Role_Playing_Game.mp3',
            ),
          ),
        );
      } else if (option == AudioSourceOptions.Asset) {
        await _player.setAudioSource(
          AudioSource.asset('assets/audio/sample.mp3'),
        );
      }
    } catch (e) {
      // print('Error loading audio source: $e');
    }
  }

  Widget _sourceSelect() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        MaterialButton(
          color: Colors.blue,
          child: const Text('Network'),
          onPressed: () {
            _setupAudioPlayer(AudioSourceOptions.Network);
          },
        ),
        MaterialButton(
          color: Colors.blue,
          child: const Text('Asset'),
          onPressed: () {
            _setupAudioPlayer(AudioSourceOptions.Asset);
          },
        ),
      ],
    );
  }

  Widget _progressBar() {
    return StreamBuilder<Duration>(
      stream: _player.positionStream,
      builder: (context, snapshot) {
        return ProgressBar(
          progress: snapshot.data ?? Duration.zero,
          buffered: _player.bufferedPosition,
          total: _player.duration ?? Duration.zero,
          onSeek: (duration) {
            _player.seek(duration);
          },
        );
      },
    );
  }

  Widget _playbackControlButton() {
    return StreamBuilder<PlayerState>(
      stream: _player.playerStateStream,
      builder: (context, snapshot) {
        final processingState = snapshot.data?.processingState;
        final playing = snapshot.data?.playing;

        if (processingState == ProcessingState.loading ||
            processingState == ProcessingState.buffering) {
          return Container(
            margin: const EdgeInsets.all(8.0),
            width: 64,
            height: 64,
            child: const CircularProgressIndicator(),
          );
        } else if (playing != true) {
          return IconButton(
            icon: const Icon(Icons.play_arrow, size: 64),
            onPressed: () {
              _player.play();
            },
          );
        } else if (processingState != ProcessingState.completed) {
          return IconButton(
            icon: const Icon(Icons.pause, size: 64),
            onPressed: () {
              _player.pause();
            },
          );
        } else {
          return IconButton(
            icon: const Icon(Icons.replay, size: 64),
            onPressed: () {
              _player.seek(Duration.zero);
            },
          );
        }
      },
    );
  }

  Widget _controlButtons() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        StreamBuilder(
          stream: _player.speedStream,
          builder: (context, snapshot) {
            return Row(
              children: [
                const Icon(Icons.speed),
                Slider(
                  min: 0.25,
                  max: 3,
                  divisions: 12,
                  value: snapshot.data ?? 1,
                  onChanged: (value) async {
                    await _player.setSpeed(value);
                  },
                ),
              ],
            );
          },
        ),
        StreamBuilder(
          stream: _player.volumeStream,
          builder: (context, snapshot) {
            return Row(
              children: [
                const Icon(Icons.volume_up),
                Slider(
                  min: 0,
                  max: 3,
                  divisions: 4,
                  value: snapshot.data ?? 1,
                  onChanged: (value) async {
                    await _player.setVolume(value);
                  },
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
