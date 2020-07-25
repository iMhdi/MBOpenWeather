#
# Be sure to run `pod lib lint MBOpenWeather.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MBOpenWeather'
  s.version          = '0.1.0'
  s.summary          = 'MBOpenWeather is a pod that uses OpenWeatherMap API to return weather information for a specific location.'

  s.description      = <<-DESC
MBOpenWeather is a simple OpenWeatherMap API Wrapper that allows for :

- [x] Making seemless API Calls
- [x] Retrieving Weather information about a specified location (By ID, Coordinates or Name)
- [x] Returning simplified, human-readable values
DESC

  s.homepage         = 'https://github.com/iMhdi/MBOpenWeather'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'm.boukhris@gmail.com' => 'm.boukhris@gmail.com' }
  s.source           = { :git => 'https://github.com/iMhdi/MBOpenWeather.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'

  s.source_files = 'MBOpenWeather/Classes/**/*'
  
end
