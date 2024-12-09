#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_pangle_global_ads.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_pangle_global_ads'
  s.version          = '1.1.0'
  s.summary          = 'A professional Flutter advertising plugin for Pangle Global'
  s.description      = <<-DESC
A Flutter plugin for integrating Pangle Global advertising SDK
                       DESC
  s.homepage         = 'https://global.flutterads.top/'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'FlutterAds' => '1300326388@qq.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.platform = :ios, '12.0'
  # Pod:https://github.com/CocoaPods/Specs/tree/master/Specs/d/1/c/Ads-Global
  s.dependency 'Ads-Global', '6.3.1.0'
  s.static_framework = true

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }

  # If your plugin requires a privacy manifest, for example if it uses any
  # required reason APIs, update the PrivacyInfo.xcprivacy file to describe your
  # plugin's privacy impact, and then uncomment this line. For more information,
  # see https://developer.apple.com/documentation/bundleresources/privacy_manifest_files
  # s.resource_bundles = {'flutter_pangle_global_ads_privacy' => ['Resources/PrivacyInfo.xcprivacy']}
end
