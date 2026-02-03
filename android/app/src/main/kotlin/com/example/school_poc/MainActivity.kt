package com.example.school_poc

import android.speech.tts.TextToSpeech
import android.speech.tts.UtteranceProgressListener
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.util.*
import android.os.Bundle

class MainActivity: FlutterActivity() {

    private val CHANNEL = "com.example.school_poc/tts_native"
    private lateinit var tts: TextToSpeech
    private var pendingResult: MethodChannel.Result? = null
    private var currentFilePath: String? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            pendingResult = result

            if (call.method == "synthesizeToFile") {
                val text = call.argument<String>("text") ?: ""
                val filePath = call.argument<String>("filePath") ?: ""
                val utteranceId = call.argument<String>("utteranceId") ?: "default_tts"

                if (text.isEmpty() || filePath.isEmpty()) {
                    result.error("INVALID_ARGS", "Text or file path missing", null)
                    pendingResult = null
                    return@setMethodCallHandler
                }

                synthesizeToFile(text, filePath, utteranceId)
            } else {
                result.notImplemented()
            }
        }

        tts = TextToSpeech(this) { status ->
            if (status == TextToSpeech.SUCCESS) {
                tts.language = Locale("en", "IN")
                tts.setSpeechRate(0.9f)
                tts.setPitch(1.0f)
                println("TTS initialized successfully - engine: ${tts.defaultEngine}")
            } else {
                println("TTS init failed: $status")
            }
        }

        tts.setOnUtteranceProgressListener(object : UtteranceProgressListener() {
            override fun onStart(utteranceId: String?) {
                println("TTS synthesis started: $utteranceId")
            }

            override fun onDone(utteranceId: String?) {
                println("TTS synthesis completed: $utteranceId")
                val path = currentFilePath
                if (path != null && File(path).exists()) {
                    pendingResult?.success(path)
                } else {
                    pendingResult?.error("FILE_NOT_FOUND", "File was not created", null)
                }
                pendingResult = null
                currentFilePath = null
            }

            override fun onError(utteranceId: String?) {
                println("TTS error for utterance: $utteranceId")
                pendingResult?.error("TTS_ERROR", "Synthesis failed", null)
                pendingResult = null
                currentFilePath = null
            }

            override fun onError(utteranceId: String?, errorCode: Int) {
                onError(utteranceId)
            }
        })
    }

    private fun synthesizeToFile(text: String, filePath: String, utteranceId: String) {
        currentFilePath = filePath

        // Correct: use Bundle, not HashMap
        val params = Bundle().apply {
            putString(TextToSpeech.Engine.KEY_PARAM_UTTERANCE_ID, utteranceId)
        }

        val file = File(filePath)
        file.parentFile?.mkdirs() // ensure parent dirs exist

        val status = tts.synthesizeToFile(text, params, file, utteranceId)

        if (status != TextToSpeech.SUCCESS) {
            println("synthesizeToFile failed with status: $status")
            pendingResult?.error("NATIVE_FAILED", "synthesizeToFile returned $status", null)
            pendingResult = null
            currentFilePath = null
        } else {
            println("synthesizeToFile started successfully for utterance: $utteranceId")
        }
    }

    override fun onDestroy() {
        tts.shutdown()
        super.onDestroy()
    }
}