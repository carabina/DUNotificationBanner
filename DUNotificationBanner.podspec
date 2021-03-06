Pod::Spec.new do |s|
  s.name             = 'DUNotificationBanner'
  s.version          = '1.0.4'
  s.summary          = 'A drop-in-solution to present banner notifications in any UIViewController.'
  s.description      = <<-DESC
                        Use this pod to display in app notifications in real time it, the source of the notifications
                        doesn't matter, it can be from API or from scehduled events, it just works!.
                       DESC
  s.homepage         = 'https://github.com/duriana/DUNotificationBanner'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'essame' => 'essam.a0@gmail.com' }
  s.source           = { :git => 'https://github.com/duriana/DUNotificationBanner.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.source_files = 'DUNotificationBanner/Classes/**/*'
  s.public_header_files = 'DUNotificationBanner/Classes/DUNotificationBannerPresentationManager.h'
  s.dependency 'TTLayoutSupport', '~> 0.4.0'
end
