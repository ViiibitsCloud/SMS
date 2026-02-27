
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:share_plus/share_plus.dart';
import 'package:school_poc/services/tts_native_service.dart';
import 'dart:io';
import 'dart:async';


class AnnouncementScreen extends StatefulWidget {
  const AnnouncementScreen({super.key});

  @override
  State<AnnouncementScreen> createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AnnouncementScreen> {
  final _textController = TextEditingController();
  final _audioPlayer = AudioPlayer(); 

  String? _audioPath;
  bool _generating = false;
  bool _ready = false;
  bool _isPlaying = false;
  int _secondsRemaining = 30;
bool _canShare = false;
Timer? _timer;

  @override
  void initState() {
    super.initState();
    _initPlayer();
  }

  void _initPlayer() {
    _audioPlayer.playerStateStream.listen((state) {
      setState(() {
        _isPlaying = state.playing;
      });
      if (state.processingState == ProcessingState.completed) {
        setState(() => _isPlaying = false);
      }
    });
  }

  Future<void> _generateAudio() async {
    final text = _textController.text.trim();
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enter text first")));
      return;
    }

    setState(() {
      _generating = true;

      _ready = false;
    });

    try {
      final savedPath = await TtsNativeService.synthesizeAndSave(text: text);

      if (savedPath != null && File(savedPath).existsSync()) {
        setState(() {
          _audioPath = savedPath;
          _ready = true;
          _startCountdown();
          _generating = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Audio saved: ${savedPath.split('/').last}")),
        );
      } else {
        throw Exception("Audio file not created");
      }
    } catch (e) {
      print("Generation failed: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to generate audio: $e")),
      );
      setState(() => _generating = false);
    }
  }

  Future<void> _playAudio() async {
    if (_audioPath == null || !_ready) return;

    try {
      await _audioPlayer.setFilePath(_audioPath!);
      await _audioPlayer.play();
      setState(() => _isPlaying = true);
    } catch (e) {
      print("Play error: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Playback failed: $e")));
    }
  }

  Future<void> _stopAudio() async {
    await _audioPlayer.stop();
    setState(() => _isPlaying = false);
  }
  void _startCountdown() {
  setState(() {
    _secondsRemaining = 30;
    _canShare = false;
  });

  _timer?.cancel();
  _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
    if (_secondsRemaining > 0) {
      setState(() {
        _secondsRemaining--;
      });
    } else {
      timer.cancel();
      setState(() {
        _canShare = true;
      });
    }
  });
}

  Future<void> _shareAudio() async {
    if (_audioPath == null || !_ready) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No audio to share")));
      return;
    }

    final file = File(_audioPath!);
    if (!await file.exists()) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Audio file missing")));
      return;
    }

    try {
      await Share.shareXFiles(
        [XFile(_audioPath!, mimeType: 'audio/wav')],
        text: "📢 School Announcement\n\n${_textController.text}",
        subject: "School Announcement Audio",
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Share failed: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Announcements"),
      backgroundColor: Colors.blue[900],
      foregroundColor: Colors.white,),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height:20),
              const Text(
                "Enter the announcement.",
                style: TextStyle(fontSize: 24, color: Colors.black87),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _textController,
                maxLines: 6,
                decoration: const InputDecoration(
                  labelText: "Announcement text",
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: 24),
              Column(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(52),
                      // backgroundColor: _generating ? Colors.grey : Theme.of(context).colorScheme.primary,
                    ),
                    icon: _generating
                        ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2.4))
                        : const Icon(Icons.record_voice_over),
                    label: Text(_generating ? "Generating..." : "Generate Audio"),
                    onPressed: _generating ? null : _generateAudio,
                  ),
                  if (_ready && !_canShare)
  Padding(
    padding: const EdgeInsets.only(top: 12),
    child: Text(
      "You can share in $_secondsRemaining seconds",
      style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
    ),
  ),
                    const SizedBox(height: 12),
                  ElevatedButton.icon(
        
                    icon: const Icon(Icons.share),
                    label: const Text("Share"),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(52),
                      backgroundColor: Colors.green[700], foregroundColor: Colors.white),
                    onPressed: _canShare ? _shareAudio : null,
                  ),
                ],
              ),
              const SizedBox(height: 32),
              if (_ready)
                Card(
                  color: Colors.green[50],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: Icon(
                      _isPlaying ? Icons.pause_circle_filled_rounded : Icons.play_circle_fill_rounded,
                      color: Colors.green,
                      size: 40,
                    ),
                    title: Text(_isPlaying ? "Playing..." : "Play generated audio"),
                    subtitle: Text(_audioPath!.split('/').last, maxLines: 1, overflow: TextOverflow.ellipsis),
                    onTap: _isPlaying ? _stopAudio : _playAudio,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _textController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }
}
