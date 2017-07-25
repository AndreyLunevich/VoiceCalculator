source 'https://github.com/CocoaPods/Specs.git'

# Disable sending stats
ENV['COCOAPODS_DISABLE_STATS'] = 'true'

platform :ios, '10.0'

use_frameworks!
inhibit_all_warnings!

target 'VoiceCalculator' do

	# reactive
	pod 'RxSwift', '~> 3.0'
	pod 'RxCocoa', '~> 3.0'

    # unit tests
    target 'VoiceCalculatorTests' do
      	inherit! :search_paths

        pod 'Quick', '~> 1.0'
        pod 'Nimble', '~> 7.0'
    end
end
