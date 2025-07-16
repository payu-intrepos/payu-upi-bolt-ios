Pod::Spec.new do |s|
  s.name                = "PayUIndia-UPIBoltBaseKit"
  s.version             = "2.0.0-alpha.5"
  s.license             = "MIT"
  s.homepage            = "https://github.com/payu-intrepos/payu-upi-bolt-ios"
  s.author              = { "PayUbiz" => "contact@payu.in"  }

  s.summary             = "The PayUUPIBoltBaseKit SDK provides basic classes and method used across other framewroks"
  s.description         = "The PayUUPIBoltBaseKit SDK provides basic classes and method used across other framewroks."

  s.source              = { :git => "https://github.com/payu-intrepos/payu-upi-bolt-ios.git",
                            :tag => "#{s.version}"
                          }
  
  s.pod_target_xcconfig = {
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64 x86_64'
  }

  s.ios.deployment_target = "13.0"
  s.vendored_frameworks = 'Frameworks/PayUUPIBoltBaseKit.xcframework'
  
end
