[![Version](https://img.shields.io/cocoapods/v/DMSwipeCards.svg?style=flat)](http://cocoadocs.org/docsets/DMSwipeCards)
![License](https://img.shields.io/cocoapods/l/DMSwipeCards.svg?style=flat)
[![twitter: @dylan36032](http://img.shields.io/badge/twitter-%40dylan36032-blue.svg?style=flat)](https://twitter.com/dylan36032)

![image](screenshot_1482145004.png)

## Features

- Swift 3
- Custom views for the card & overlay
- Generic
- Dynamically add new cards on top or on the bottom
- Lazy view loading

## Setup

	pod 'DMSwipeCards'
	

## Usage

First import the module:

	import DMSwipeCards
	

Next create an instance of a `DMSwipeCardsView`:  
(`Element` can be your custom model, or just `String`)

	let swipeView = DMSwipeCardsView<Element>(frame: frame,
									 viewGenerator: viewGenerator,
		                          overlayGenerator: overlayGenerator)
		                          
Views get loaded lazy, so you have to provide `DMSwipeCardsView` with a ViewGenerator and optionally an OverlayGenerator.

	let viewGenerator: (String, CGRect) -> (UIView) = { (element: Element, frame: CGRect) -> (UIView) in
		// return a UIView here
	}

	let overlayGenerator: (SwipeMode, CGRect) -> (UIView) = { (mode: SwipeMode, frame: CGRect) -> (UIView) in
		// return a UIView here
	}
	
### Adding cards

To add new cards, just call the `addCards` method with an array of the previously defined `Element`:

	swipeView.addCards([Element], onTop: true)

### Delegate

`DMSwipeCardsView` has a delegate property so you can get informed when a card has been swipped. The delegate has to implement following methods:

	func swipedLeft(_ object: Any)
	func swipedRight(_ object: Any)
	func cardTapped(_ object: Any)
	func reachedEndOfStack()

The `object` parameter is guarenteed to have the type `Element`. Sadly generics don't work here.  


## Example

For a nice working demo sample, please take a look the [Example](https://github.com/D-32/DMSwipeCards/tree/master/Example) project.  
To run the example, first run `pod install` in the `Example` directory.

## Credits
Loosly based on [TinderSimpleSwipeCards](https://github.com/cwRichardKim/TinderSimpleSwipeCards)

