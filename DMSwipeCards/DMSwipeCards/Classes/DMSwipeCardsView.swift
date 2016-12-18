//
//  DMSwipeCardsView.swift
//  Pods
//
//  Created by Dylan Marriott on 18/12/16.
//
//

import Foundation
import UIKit

protocol DMSwipeCardsViewDelegate: class {

}

public class DMSwipeCardsView<Element>: UIView {

	weak var delegate: DMSwipeCardsViewDelegate?
	var bufferSize: Int = 2

	private let viewGenerator: ViewGenerator
	private var allCards = [Element]()
	private var loadedCards = [DMSwipeCard]()

	public typealias ViewGenerator = (_ element: Element, _ frame: CGRect) -> (UIView)
	public init(frame: CGRect, viewGenerator: @escaping ViewGenerator) {
		self.viewGenerator = viewGenerator
		super.init(frame: frame)
	}

	override public init(frame: CGRect) {
		fatalError("Please use init(frame:,viewGenerator)")
	}
	
	required public init?(coder aDecoder: NSCoder) {
		fatalError("Please use init(frame:,viewGenerator)")
	}

	public func addCards(_ elements: [Element], onTop: Bool = false) {
		if onTop {
			for element in elements.reversed() {
				allCards.insert(element, at: 0)
			}
		} else {
			for element in elements {
				allCards.append(element)
			}
		}

		for element in elements {
			allCards.append(element)
			if loadedCards.count < bufferSize {
				let cardView = DMSwipeCard(frame: self.bounds)
				let sv = self.viewGenerator(element, cardView.bounds)
				cardView.addSubview(sv)
				if loadedCards.isEmpty {
					self.addSubview(cardView)
				} else {
					self.insertSubview(cardView, belowSubview: loadedCards.last!)
				}
				self.loadedCards.append(cardView)
			}
		}
	}
}
