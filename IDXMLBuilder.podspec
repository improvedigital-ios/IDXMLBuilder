#
# Be sure to run `pod lib lint IDXMLBuilder.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'IDXMLBuilder'
  s.version          = '0.1.5'
  s.summary          = 'IDXMLBuilder created for easy XML files generation'
  s.description      = 'Detailed description...'
  s.homepage         = 'https://github.com/improvedigital-ios/IDXMLBuilder'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Andrey Bronnikov' => 'brand_nsk@mail.ru' }
  s.source           = { :git => 'https://github.com/improvedigital-ios/IDXMLBuilder.git', :branch => "master" }

  s.ios.deployment_target = '9.0'

  s.source_files = 'Classes/**/*.{h,m}'

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
end
