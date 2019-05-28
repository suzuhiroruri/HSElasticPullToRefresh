Pod::Spec.new do |spec|
  spec.name         = "HSElasticPullToRefresh"
  spec.version      = "1.0"
  spec.authors      = { "Hiromasa Suzuki" => "suzuhiroruri@gmail.com" }
  spec.homepage     = "https://github.com/suzuhiroruri/HSElasticPullToRefresh"
  spec.summary      = "Elastic pull to refresh compontent developed in Swift"
  spec.source       = { :git => "https://github.com/suzuhiroruri/HSElasticPullToRefresh.git",
                        :tag => '1.1' }
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.platform     = :ios, '8.0'
  spec.source_files = "HSElasticPullToRefresh/*.swift"

  spec.requires_arc = true

  spec.ios.deployment_target = '8.0'
  spec.ios.frameworks = ['UIKit', 'Foundation']
end
