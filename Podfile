platform :ios, ENV['MINIMUM_IOS_VERSION']

# project '../../AibaShop.xcodeproj'
# workspace '../../AibaShop.xcworkspace'

target ENV['IOS_TARGET_NAME'] do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  inhibit_all_warnings!
  pod 'FirebaseAppCheck'
  pod 'FirebaseAuth'
  pod 'FirebaseFirestore'
  pod 'FirebaseDatabase'
  pod 'FirebaseMessaging'
  pod 'Firebase/RemoteConfig'
  pod 'GoogleMLKit/BarcodeScanning'
  pod 'GoogleSignIn'
  pod 'LineSDKSwift'
  pod 'SDWebImage'
  pod 'SnapKit'
  pod 'Parchment'
 # pod 'tappay-ios-sdk',:git => 'https://github.com/TapPay/tappay-ios-sdk.git'
  target :"#{ENV['IOS_TARGET_NAME']}-UnitTests"
end

target 'NotificationExtension' do
  use_frameworks!
  inhibit_all_warnings!
  pod 'FirebaseMessaging'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
    end
    if target.name == 'BoringSSL-GRPC'
      target.source_build_phase.files.each do |file|
        if file.settings && file.settings['COMPILER_FLAGS']
          flags = file.settings['COMPILER_FLAGS'].split
          flags.reject! { |flag| flag == '-GCC_WARN_INHIBIT_ALL_WARNINGS' }
          file.settings['COMPILER_FLAGS'] = flags.join(' ')
        end
      end
    end
  end
end
