Pod::Spec.new do |s|
          #1.
          s.name               = "ABGaugeViewKit"
          #2.
          s.version            = "1.0.1"
          #3.  
          s.summary         = "ABGaugeViewKit is a framework which will help you to add Gauge View in your iOS App."
          #4.
          s.homepage        = "https://www.linkedin.com/in/ajaybhanushali/"
          #5.
          s.license              = "MIT"
          #6.
          s.author               = "Ajay Bhanushali"
          #7.
          s.platform            = :ios, "11.0"
          #8.
          s.source              = { :git => "https://github.com/AjayBhanushali/ABGaugeViewKit.git", :tag => "1.0.1" }
          #9.
          s.source_files     = "ABGaugeViewKit", "ABGaugeViewKit/**/*.{h,m,swift}"
    end