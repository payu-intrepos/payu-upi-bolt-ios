Pod::Spec.new do |s|
  s.name                = "PayUIndia-UPIBoltKit"
  s.version             = "1.0.0-alpha.0"
  s.license             = "MIT"
  s.homepage            = "https://github.com/payu-intrepos/payu-upi-bolt-ios"
  s.author              = { "PayUbiz" => "contact@payu.in"  }

  s.summary             = "The PayUUPIBoltKit SDK provides core functionality, used across other framewroks"
  s.description         = "The PayUUPIBoltKit SDK provides core functionality, used across other framewroks."

  s.source              = { :git => "https://github.com/payu-intrepos/payu-upi-bolt-ios.git",
                            :tag => "#{s.version}"
                          }
  
  s.pod_target_xcconfig = {
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64 x86_64'
  }
  
  s.ios.deployment_target = "17.0"
  s.vendored_frameworks = 'Frameworks/PayUUPIBoltKit.xcframework'

  s.dependency            'PayUIndia-UPIBoltBaseKit', '~> 1.0.0-alpha.0'
  s.dependency            'PayUIndia-AssetLibrary', '~> 4.0'
  s.dependency            'PayUIndia-CrashReporter', '~> 4.0'
  s.dependency            'PayUIndia-NetworkReachability', '~> 2.1'
  s.dependency            'PayUIndia-Analytics', '~> 4.0'

end
