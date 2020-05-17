#
# Be sure to run `pod lib lint RxSemaphore.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RxSemaphore'
  s.version          = '0.2.0'
  s.summary          = 'Single Semaphore Plus Cancellable in RxSwift'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.homepage         = 'https://github.com/Adelais0/RxSemaphore'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Adelais0' => 'lilingfengzero@gmail.com' }
  s.source           = { :git => 'https://github.com/Adelais0/RxSemaphore.git', :tag => s.version.to_s }

  s.swift_versions = '5.0', '5.1'
  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9'
  s.watchos.deployment_target = '3.0'
  s.tvos.deployment_target = '9.0'

  s.source_files = 'RxSemaphore/**/*'

  s.dependency 'RxSwift', '~> 5.0'
end
