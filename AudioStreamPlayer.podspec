#
# Be sure to run `pod lib lint AudioStreamPlayer.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AudioStreamPlayer'
  s.version          = '0.1.0'
  s.summary          = 'From AudioStreamPlayer you can stream an audio file using url the best thing is that it can also stream .wav files also.Put the streaming url in the textfield provided it will start streaming the audio file.It also tell you the total duration of file.I use streamKit classes for audio streaming.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/basitmashwani/AudioStreamPlayer'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Syed Abdul Basit' => 'abdul.basit@mercurialminds.com' }
  s.source           = { :git => 'https://github.com/basitmashwani/AudioStreamPlayer.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/basitmashwani'

  s.ios.deployment_target = '8.0'

  s.source_files = 'AudioStreamPlayer/Classes/**/*'
  
  # s.resource_bundles = {
  #   'AudioStreamPlayer' => ['AudioStreamPlayer/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
