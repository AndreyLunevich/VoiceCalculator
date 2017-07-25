pod deintegrate
rm -rf Pods
rm -rf Podfile.lock
rm -rf *.xcworkspace
pod repo update
pod install
rm -rf ~/Library/Developer/Xcode/DerivedData