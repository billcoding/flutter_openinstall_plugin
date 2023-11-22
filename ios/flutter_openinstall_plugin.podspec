#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_openinstall_plugin.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_openinstall_plugin'
  s.version          = '1.0.0'
  s.summary          = 'The flutter plugin for openinstall upgraded based on https://github.com/OpenInstall/openinstall-flutter-plugin'
  s.description      = <<-DESC
A new Flutter plugin project.
                       DESC
  s.homepage         = 'https://github.com/rwscode/flutter_openinstall_plugin'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'rwscode.com' => 'opensource@rwscode.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.platform = :ios, '11.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
end
