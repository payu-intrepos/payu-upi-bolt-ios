Pod::Spec.new do |s|
  s.name                = "PayUIndia-UPIBoltUIKit"
  s.version             = "alpha.1"
  s.license             = "MIT"
  s.homepage            = "https://github.com/payu-intrepos/payu-upi-bolt-ios"
  s.author              = { "PayUbiz" => "contact@payu.in"  }

  s.summary             = "The PayUUPIBoltUIKit SDK provides UPI features"
  s.description         = "The PayUUPIBoltUIKit SDK provides UPI features."

  s.source              = { :git => "https://github.com/payu-intrepos/payu-upi-bolt-ios.git",
                            :tag => "#{s.version}"
                          }

  s.pod_target_xcconfig = {
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64 x86_64'
  }

  s.ios.deployment_target = "13.0"
  s.vendored_frameworks = 'Frameworks/PayUUPIBoltUIKit.xcframework'

  s.dependency            'PayUIndia-UPIBoltKit', 'alpha.1'
  s.dependency            'PayUIndia-AssetLibrary', '~> 4.0'

end
