package com.hearts.scan;

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
    com.ko2ic.imagedownloader.ImageDownloaderPlugin.registerWith(shimPluginRegistry.registrarFor("com.ko2ic.imagedownloader.ImageDownloaderPlugin"));
  
  }
}