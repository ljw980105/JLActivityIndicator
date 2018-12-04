Pod::Spec.new do |s|
  s.name             = 'JLActivityIndicator'
  s.version          = '2.0'
  s.summary          = 'An iOS Activity Indicator Capable of Drawing Custom Paths!'
  s.description      = 'This activity indicator allows you to supply any image or UIBezierPath to the indicator, creating amazing loading effects!'
 
  s.homepage         = 'https://github.com/ljw980105/JLActivityIndicator'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jing Wei Li' => 'ljw9801055@gmail.com' }
  s.source           = { :git => 'https://github.com/ljw980105/JLActivityIndicator.git', :tag => s.version.to_s }
 
  s.ios.deployment_target = '9.0'
  s.source_files = 'JLActivityIndicator/*.{h,swift}'
  s.framework    = 'UIKit'
 
end