Pod::Spec.new do |s|
  s.name         = "NitroNSArrayCategories"
  s.version      = "1.0.1"
  s.summary      = "NSArray missing features and utilities"
  s.homepage     = "http://github.com/danielalves/NitroNSArrayCategories"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = "Daniel L. Alves"
  s.social_media_url   = "http://twitter.com/alveslopesdan"
  s.source       = { :git => "https://github.com/danielalves/NitroNSArrayCategories.git", :tag => s.version.to_s }
  s.platform     = :ios
  s.source_files = "NitroNSArrayCategories/NitroNSArrayCategories"
  s.xcconfig     = { 'OTHER_LDFLAGS' => '-ObjC' }
  s.requires_arc = true
  s.dependency 'NitroMisc', '~> 1.0.1'
end
