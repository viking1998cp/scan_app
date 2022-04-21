import UIKit
import Flutter
import Firebase 
import google_mobile_ads
@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
     GeneratedPluginRegistrant.register(with: self)
     let nativeAdFactory:NativeAdFactoryExample! = NativeAdFactoryExample()
    // TODO: Register ListTileNativeAdFactory
     FLTGoogleMobileAdsPlugin.registerNativeAdFactory(self,
                                                factoryId:"adFactoryExample",
                                                nativeAdFactory:nativeAdFactory)
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
import google_mobile_ads
// The UnifiedNativeAdView.xib and example GADUnifiedNativeAdView is provided and
// explained by https://developers.google.com/admob/ios/native/advanced.
class NativeAdFactoryExample : NSObject, FLTNativeAdFactory {
    
     func createNativeAd(_ nativeAd: GADNativeAd,
                        customOptions: [AnyHashable : Any]? = nil) -> GADNativeAdView? {
        let nibView = Bundle.main.loadNibNamed("ListTileNativeAdView", owner: nil, options: nil)!.first
       
      let nativeAdView = nibView as! GADNativeAdView

      // Associate the native ad view with the native ad object. This is
      // required to make the ad clickable.
      nativeAdView.nativeAd = nativeAd

      // Populate the native ad view with the native ad assets.
      // The headline is guaranteed to be present in every native ad.
      (nativeAdView.headlineView as! UILabel).text = nativeAd.headline

      // These assets are not guaranteed to be present. Check that they are before
      // showing or hiding them.
      (nativeAdView.bodyView as? UILabel)?.text = nativeAd.body
        nativeAdView.bodyView?.isHidden = nativeAd.body == nil

      (nativeAdView.callToActionView as? UIButton)?.setTitle(nativeAd.callToAction,
                                                       for: .normal)
        nativeAdView.callToActionView?.isHidden = nativeAd.callToAction == nil

      (nativeAdView.iconView as? UIImageView)?.image = nativeAd.icon?.image
        nativeAdView.iconView?.isHidden = nativeAd.icon == nil

      (nativeAdView.storeView as? UILabel)?.text = nativeAd.store
        nativeAdView.storeView?.isHidden = nativeAd.store == nil

      (nativeAdView.priceView as? UILabel)?.text = nativeAd.price
        nativeAdView.priceView?.isHidden = nativeAd.price == nil

      (nativeAdView.advertiserView as? UILabel)?.text = nativeAd.advertiser
        nativeAdView.advertiserView?.isHidden = nativeAd.advertiser == nil

      // In order for the SDK to process touch events properly, user interaction
      // should be disabled.
        nativeAdView.callToActionView?.isUserInteractionEnabled = false

      return nativeAdView
    }
}
