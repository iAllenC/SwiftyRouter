Pod::Spec.new do |spec|
  spec.name         = "SwiftyURLRouter"
  spec.version      = "2.0.2"
  spec.summary      = "A light weight router for swift "
  spec.homepage     = "https://github.com/iAllenC/SwiftyRouter"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "iAllenC" => "373381941@qq.com" }
  spec.platform     = :ios, '9.0'
  spec.source       = { :git => "https://github.com/iAllenC/SwiftyRouter.git", :tag => "#{spec.version}" }
  spec.source_files = 'Sources/*.{swift}'
  # spec.exclude_files = "Classes/Exclude"
  # spec.public_header_files = "Classes/**/*.h"

end
