package com.hearts.mygaragelight;

import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.plugins.shim.ShimPluginRegistry;


public class EmbeddingV1Activity extends FlutterActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    FlutterEngine flutterEngine = new FlutterEngine(this);
    ShimPluginRegistry shimPluginRegistry = new ShimPluginRegistry(flutterEngine);
    vn.hunghd.flutter.plugins.imagecropper.ImageCropperPlugin.registerWith(shimPluginRegistry.registrarFor("vn.hunghd.flutter.plugins.imagecropper.ImageCropperPlugin"));
    // com.tfliteflutter.tflite_flutter_plugin.TfliteFlutterPlugin.registerWith(shimPluginRegistry.registrarFor("com.tfliteflutter.tflite_flutter_plugin.TfliteFlutterPlugin"));
  }
}