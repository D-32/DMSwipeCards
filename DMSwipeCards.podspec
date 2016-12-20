Pod::Spec.new do |s|
  s.name             = 'DMSwipeCards'
  s.version          = '1.0.2'
  s.summary          = 'Tinder like card interface'

  s.description      = <<-DESC
Written in Swift 3, supports custom views for the card and the overlay. Views get loaded lazily, so there's no issues in loading a huge amount of cards.
                       DESC

  s.homepage         = 'https://github.com/d-32/DMSwipeCards'
  s.screenshots     = 'https://raw.githubusercontent.com/D-32/DMSwipeCards/master/Screenshots/01.png', 'https://raw.githubusercontent.com/D-32/DMSwipeCards/master/Screenshots/02.png', 'https://raw.githubusercontent.com/D-32/DMSwipeCards/master/Screenshots/03.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Dylan Marriott' => 'info@d-32.com' }
  s.source           = { :git => 'https://github.com/d-32/DMSwipeCards.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/dylan36032'

  s.ios.deployment_target = '8.0'

  s.source_files = 'DMSwipeCards/Classes/**/*'
end
