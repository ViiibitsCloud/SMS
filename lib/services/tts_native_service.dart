
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class TtsNativeService {
  static const MethodChannel _channel = MethodChannel('com.example.school_poc/tts_native');

  static Future<String?> synthesizeAndSave({
    required String text,
    String? utteranceId,
  }) async {
    try {
      final dir = await getTemporaryDirectory(); // or getApplicationDocumentsDirectory()
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final path = '${dir.path}/tts_$timestamp.wav'; // .wav is usually safer for TTS

      final result = await _channel.invokeMethod<String>('synthesizeToFile', {
        'text': text,
        'filePath': path,
        'utteranceId': utteranceId ?? 'tts_${timestamp}',
      });

      if (result != null && File(result).existsSync()) {
        return result; // real path returned from native
      } else {
        print('Native returned path but file not found: $result');
        return null;
      }
    } catch (e) {
      print('TTS native error: $e');
      return null;
    }
 
 }
}