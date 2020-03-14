Pod::Spec.new do |spec|
  spec.name         = "URLRouter"
  spec.version      = "0.0.1"
  spec.summary      = "A light weight router for swift "
  spec.homepage     = "https://github.com/iAllenC/URLRouter"
  spec.license    = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "iAllenC" => "373381941@qq.com" }
  spec.ios.deployment_target = "9.0"
  spec.osx.deployment_target = "10.8"
  spec.source       = { :git => "https://github.com/iAllenC/URLRouter.git", :tag => "#{spec.version}" }
  spec.source_files  = 'Source/*.{h,m}'
  # spec.exclude_files = "Classes/Exclude"
  # spec.public_header_files = "Classes/**/*.h"

end
