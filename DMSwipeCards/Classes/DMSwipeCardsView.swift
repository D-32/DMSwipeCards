//
//  DMSwipeCardsView.swift
//  Pods
//
//  Created by Dylan Marriott on 18/12/16.
//
//

import Foundation
import UIKit

public enum SwipeMode {
	case left
	case right
}

public protocol DMSwipeCardsViewDelegate: class {
	func swipedLeft(_ object: Any)
	func swipedRight(_ object: Any)
  func cardTapped(_ object: Any)
	func reachedEndOfStack()
}

public class DMSwipeCardsView<Element>: UIView {

	public weak var delegate: DMSwipeCardsViewDelegate?
	public var bufferSize: Int = 2

	fileprivate let viewGenerator: ViewGenerator
	fileprivate let overlayGenerator: OverlayGenerator?
	fileprivate var allCards = [Element]()
	fileprivate var loadedCards = [DMSwipeCard]()

	public typealias ViewGenerator = (_ element: Element, _ frame: CGRect) -> (UIView)
	public typealias OverlayGenerator = (_ mode: SwipeMode, _ frame: CGRect) -> (UIView)
	public init(frame: CGRect,
	            viewGenerator: @escaping ViewGenerator,
	            overlayGenerator: OverlayGenerator? = nil) {
		self.overlayGenerator = overlayGenerator
		self.viewGenerator = viewGenerator
		super.init(frame: frame)
    self.isUserInteractionEnabled = false
	}

	override private init(frame: CGRect) {
		fatalError("Please use init(frame:,viewGenerator)")
	}
	
	required public init?(coder aDecoder: NSCoder) {
		fatalError("Please use init(frame:,viewGenerator)")
	}

	public func addCards(_ elements: [Element], onTop: Bool = false) {
    if elements.isEmpty {
      return
    }

    self.isUserInteractionEnabled = true

		if onTop {
			for element in elements.reversed() {
				allCards.insert(element, at: 0)
			}
		} else {
			for element in elements {
				allCards.append(element)
			}
		}

		if onTop && loadedCards.count > 0 {
			for cv in loadedCards {
				cv.removeFromSuperview()
			}
			loadedCards.removeAll()
		}

		for element in elements {
			if loadedCards.count < bufferSize {
				let cardView = self.createCardView(element: element)
				if loadedCards.isEmpty {
					self.addSubview(cardView)
				} else {
					self.insertSubview(cardView, belowSubview: loadedCards.last!)
				}
				self.loadedCards.append(cardView)
			}
		}
	}

	func swipeTopCardRight() {
		// TODO: not yet supported
		fatalError("Not yet supported")
	}

	func swipeTopCardLeft() {
		// TODO: not yet supported
		fatalError("Not yet supported")
	}
}

extension DMSwipeCardsView: DMSwipeCardDelegate {
	func cardSwipedLeft(_ card: DMSwipeCard) {
		self.handleSwipedCard(card)
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) {
			self.delegate?.swipedLeft(card.obj)
			self.loadNextCard()
		}
	}

	func cardSwipedRight(_ card: DMSwipeCard) {
		self.handleSwipedCard(card)
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) {
			self.delegate?.swipedRight(card.obj)
			self.loadNextCard()
		}
	}

  func cardTapped(_ card: DMSwipeCard) {
    self.delegate?.cardTapped(card.obj)
  }
}

extension DMSwipeCardsView {
	fileprivate func handleSwipedCard(_ card: DMSwipeCard) {
		self.loadedCards.removeFirst()
		self.allCards.removeFirst()
		if self.allCards.isEmpty {
      self.isUserInteractionEnabled = false
			self.delegate?.reachedEndOfStack()
		}
	}

	fileprivate func loadNextCard() {
		if self.allCards.count - self.loadedCards.count > 0 {
			let next = self.allCards[loadedCards.count]
			let nextView = self.createCardView(element: next)
			let below = self.loadedCards.last!
			self.loadedCards.append(nextView)
			self.insertSubview(nextView, belowSubview: below)
		}
	}

	fileprivate func createCardView(element: Element) -> DMSwipeCard {
		let cardView = DMSwipeCard(frame: self.bounds)
		cardView.delegate = self
		cardView.obj = element
		let sv = self.viewGenerator(element, cardView.bounds)
		cardView.addSubview(sv)
		cardView.leftOverlay = self.overlayGenerator?(.left, cardView.bounds)
		cardView.rightOverlay = self.overlayGenerator?(.right, cardView.bounds)
		cardView.configureOverlays()
		return cardView
	}
}
