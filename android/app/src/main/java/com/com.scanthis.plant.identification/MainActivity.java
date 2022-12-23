package com.scanthis.plant.identification;
import adroid.content.res.AssetManager;
import android.content.Context;
import android.content.pm.PackageManager;
import android.database.Cursor;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Matrix;
import android.graphics.Paint;
import android.net.Uri;
import android.os.Bundle;
import android.provider.MediaStore;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.blankj.utilcode.util.GsonUtils;
import com.blankj.utilcode.util.ImageUtils;
import com.blankj.utilcode.util.ThreadUtils;
import com.blankj.utilcode.util.ToastUtils;
import com.blankj.utilcode.util.UriUtils;
import com.google.android.play.core.assetpacks.AssetPackLocation;
import com.google.android.play.core.assetpacks.AssetPackManager;
import com.google.android.play.core.assetpacks.AssetPackManagerFactory;
import com.google.android.play.core.assetpacks.AssetPackState;
import com.google.android.play.core.assetpacks.AssetPackStates;
import com.google.android.play.core.tasks.OnCompleteListener;
import com.google.android.play.core.tasks.Task;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import io.flutter.Log;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.BasicMessageChannel;
import io.flutter.plugin.common.StringCodec;
import io.flutter.plugins.GeneratedPluginRegistrant;
import android.content.res.AssetManager;
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin;
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin.NativeAdFactory;

public class MainActivity extends FlutterActivity {

    private String MESSAGE_CHANNEL = "com.scanthis.plant.identification/message";
     String assetPackName = "install_time_asset_pack";
    AssetPackManager assetPackManager;
    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        final NativeAdFactory factory = new NativeAdFactoryExample(getLayoutInflater());
        GoogleMobileAdsPlugin.registerNativeAdFactory(flutterEngine, "adFactoryExample", factory);
        demoBasicMessageChannel1();
    }


     @Override
  public void cleanUpFlutterEngine(FlutterEngine flutterEngine) {
    GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "adFactoryExample");
  }

    public void demoBasicMessageChannel1() {
        Log.d("AAAAAAAA", "Test");
        BasicMessageChannel<String> messageChannel = new BasicMessageChannel<>(getFlutterEngine().getDartExecutor().getBinaryMessenger(),
                MESSAGE_CHANNEL, StringCodec.INSTANCE);

        messageChannel.setMessageHandler(new BasicMessageChannel.MessageHandler<String>() {
            @Override
            public void onMessage(String message, BasicMessageChannel.Reply<String> reply) {
                detectImage(MainActivity.this, message, new OnResultListener() {
                    @Override
                    public void onResult(String result) {
                        messageChannel.send(result);
                    }
                });
                reply.reply(null);
            }
        });
    }

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        AssetManager assetManager = this.getAssets();

        try {

            InputStream is = assetManager.open("install_time2.txt");
            int length = is.available();
            byte[] buffer = new byte[length];
            is.read(buffer);

        } catch (IOException e) {
            e.printStackTrace();
            Log.d("puzzle",e.getMessage() );
        }
        // assetPackManager = AssetPackManagerFactory.getInstance(this.getApplicationContext());
        // assetPackManager.getPackStates(Collections.singletonList(assetPackName))
        //         .addOnCompleteListener(new OnCompleteListener<AssetPackStates>() {
        //             @Override
        //             public void onComplete(Task<AssetPackStates> task) {
        //                 AssetPackStates assetPackStates;
        //                 try {
        //                     assetPackStates = task.getResult();
        //                     AssetPackState assetPackState =
        //                             assetPackStates.packStates().get(assetPackName);

        //                     Log.d("puzzle", "status: " + assetPackState.status() +
        //                             ", name: " + assetPackState.name() +
        //                             ", errorCode: " + assetPackState.errorCode() +
        //                             ", bytesDownloaded: " + assetPackState.bytesDownloaded() +
        //                             ", totalBytesToDownload: " + assetPackState.totalBytesToDownload() +
        //                             ", transferProgressPercentage: " + assetPackState.transferProgressPercentage());

        //                 }catch (Exception e){
        //                     Log.d("MainActivity", e.getMessage());
        //                 }
        //             }
        //         });
//                List<String> list = new ArrayList();
//        list.add(assetPackName);
//
//        assetPackManager.fetch(list);
//   initClassifier();
        Log.d("AAAAAAAA", "Test1");

    }

    private Classifier classifier;

    private static final int INPUT_SIZE = 299;
    private static final int IMAGE_MEAN = 128;
    private static final float IMAGE_STD = 128;
    private static final String INPUT_NAME = "input";
    private static final String OUTPUT_NAME = "InceptionV3/Predictions/Reshape_1";


    private String getAbsoluteAssetPath(String assetPack, String relativeAssetPath) {
        AssetPackLocation assetPackPath = assetPackManager.getPackLocation(assetPack);
        Log.d("puzzle", "invoke getAbsoluteAssetPath");

        String assetsFolderPath = assetPackPath.assetsPath();
        // equivalent to: FilenameUtils.concat(assetPackPath.path(), "assets");

       return assetsFolderPath + relativeAssetPath;

    }

    private static final String MODEL_FILE = "file:///android_asset/dog.obb";
    protected synchronized void initClassifier() {
        Log.d("AAAAAAAA", "Test2");

        if (classifier == null)
            try {
                Context contextDogDectect = null;
                try {
                    contextDogDectect = createPackageContext("com.scanthis.plant.identification", 0);
                    classifier =
                            TensorFlowImageClassifier.create(
                                    contextDogDectect.getAssets(),
                                    MODEL_FILE,
                                    getResources().getStringArray(R.array.breeds_array),
                                    INPUT_SIZE,
                                    IMAGE_MEAN,
                                    IMAGE_STD,
                                    INPUT_NAME,
                                    OUTPUT_NAME);
                }

                catch (PackageManager.NameNotFoundException e) {
                    e.printStackTrace();
                }catch (OutOfMemoryError e) {
                runOnUiThread(() -> {
                    ToastUtils.showShort("failed");
                });
            }


            } catch (OutOfMemoryError e) {
                runOnUiThread(() -> {
                    ToastUtils.showShort("failed");
                });
            }
    }

    public interface OnResultListener {
        void onResult(String result);
    }

    public void detectImage(Context mContext, String path, OnResultListener listener) {
        if (classifier == null) {
            initClassifier();
            ToastUtils.showShort("failed");
            return;
        }
        ThreadUtils.executeByIo(new ThreadUtils.SimpleTask<List<Classifier.Recognition>>() {
            @Override
            public List<Classifier.Recognition> doInBackground() throws Throwable {
                Log.d("AAAAAAAA", "Test4");

                return classifier.recognizeImage(resizeCropAndRotate(ImageUtils.getBitmap(path), getOrientation(mContext, UriUtils.file2Uri(new File(path)))));
            }

            @Override
            public void onSuccess(List<Classifier.Recognition> result) {
                ArrayList<Data> data = new ArrayList<>();
                for (Classifier.Recognition next : result) {
                    data.add(new Data(next.getTitle().replaceAll("\\d+:","").replaceAll("_"," "), Integer.parseInt(next.getId()), next.getConfidence()));
                }
                listener.onResult(GsonUtils.toJson(data));
            }
        });
    }

    public int getOrientation(Context context, Uri photoUri) {
        try (final Cursor cursor = context.getContentResolver().query(photoUri,
                new String[]{"orientation"}, null, null, null)
        ) {
            if (cursor.getCount() != 1) {
                cursor.close();
                return -1;
            }

            if (cursor.moveToFirst()) {
                final int r = cursor.getInt(0);
                cursor.close();
                return r;
            }

        } catch (Exception e) {
            return -1;
        }
        return -1;
    }

    private Bitmap resizeCropAndRotate(Bitmap originalImage, int orientation) {
        Bitmap result = Bitmap.createBitmap(INPUT_SIZE, INPUT_SIZE, Bitmap.Config.ARGB_8888);

        final float originalWidth = originalImage.getWidth();
        final float originalHeight = originalImage.getHeight();

        final Canvas canvas = new Canvas(result);

        final float scale = INPUT_SIZE / originalWidth;

        final float xTranslation = 0.0f;
        final float yTranslation = (INPUT_SIZE - originalHeight * scale) / 2.0f;

        final Matrix transformation = new Matrix();
        transformation.postTranslate(xTranslation, yTranslation);
        transformation.preScale(scale, scale);

        final Paint paint = new Paint();
        paint.setFilterBitmap(true);

        canvas.drawBitmap(originalImage, transformation, paint);

        /*
         * if the orientation is not 0 (or -1, which means we don't know), we
         * have to do a rotation.
         */
        if (orientation > 0) {
            final Matrix matrix = new Matrix();
            matrix.postRotate(orientation);

            result = Bitmap.createBitmap(result, 0, 0, INPUT_SIZE,
                    INPUT_SIZE, matrix, true);
        }

        return result;
    }
}
