# Uncomment this line to define a global platform for your project
platform :ios, '9.0'

target 'FakeKKTown' do
  use_frameworks!

  pod 'DynamicColor', '~> 3.0'
  pod 'SnapKit', '~> 3.0'
  pod 'ObjectMapper', '~> 2.0'

  # Beta dependencies for Swift 3.0
  pod 'Moya-ObjectMapper/RxSwift', :git => 'https://github.com/ivanbruel/Moya-ObjectMapper'
  pod 'Moya',       '8.0.0-beta.2'
  pod 'RxSwift',    '~> 3.0.0-beta.1'
  pod 'RxCocoa',    '~> 3.0.0-beta.1'
  # pod 'Moya/RxSwift'

  target 'FakeKKTownTests' do
    inherit! :search_paths
  end

  target 'FakeKKTownUITests' do
    inherit! :search_paths
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
      config.build_settings['MACOSX_DEPLOYMENT_TARGET'] = '10.10'
    end
  end
end