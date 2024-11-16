package com.example.platform_channel_tutorial

import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity(){
    private val channel = "com.example/platforms"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger,channel).setMethodCallHandler{
            call,result ->

            if(call.method == "callNative"){
                val flutterMessage: String? = call.argument<String?>("flutter_message")
                Toast.makeText(this,"$flutterMessage",Toast.LENGTH_LONG).show()
                val message = "Hello From Android Native"
                result.success(message)
            }
        }

    }

}
