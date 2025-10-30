Pod::Spec.new do |s|
  s.name                = "PayUIndia-UPIBoltCoreKit"
  s.version             = "3.0.0-alpha.1"
  s.license             = "MIT"
  s.homepage            = "https://github.com/payu-intrepos/payu-upi-bolt-ios"
  s.author              = { "PayUbiz" => "contact@payu.in"  }

  s.summary             = "The PayUUPIHdfcPluginKit SDK provides core functionality, used across other framewroks"
  s.description         = "The PayUUPIHdfcPluginKit SDK provides core functionality, used across other framewroks."

  s.source              = { :git => "https://github.com/payu-intrepos/payu-upi-bolt-ios.git",
                            :tag => "PayUIndia-UPIBoltCoreKit-#{s.version}" 
                          }
  
  s.pod_target_xcconfig = {
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64 x86_64'
  }
  
  s.ios.deployment_target = "13.0"
  s.vendored_frameworks = 'Frameworks/PayUUPIBoltCoreKit.xcframework'

  s.dependency            'PayUIndia-UPIBoltBaseKit', "3.0.0-alpha.1"
  s.dependency            'PayUIndia-CrashReporter', '~> 4.0'
  s.dependency            'PayUIndia-NetworkReachability', '~> 2.1'
  s.dependency            'PayUIndia-Analytics', '~> 4.0'

end
