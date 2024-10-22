Pod::Spec.new do |s|
  s.name                = "PayUIndia-UPIBoltUIKit"
  s.version             = "1.0.0-alpha.0"
  s.license             = "MIT"
  s.homepage            = "https://github.com/payu-intrepos/payu-upi-bolt-ios"
  s.author              = { "PayUbiz" => "contact@payu.in"  }

  s.summary             = "The PayUUPIBoltUIKit SDK provides UPI features."
  s.description         = "The PayUUPIBoltUIKit SDK provides UPI features."

  s.source              = { :git => "https://github.com/payu-intrepos/payu-upi-bolt-ios.git",
                            :tag => "#{s.version}"
                          }

  s.ios.deployment_target = "17.0"
  s.vendored_frameworks = 'Frameworks/PayUUPIBoltUIKit.xcframework'

  s.dependency            'PayUIndia-UPIBoltKit', '~> 1.0.0-alpha.0'

end