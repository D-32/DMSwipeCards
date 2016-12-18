//
//  ViewController.swift
//  DMSwipeCards
//
//  Created by Dylan Marriott on 12/18/2016.
//  Copyright (c) 2016 Dylan Marriott. All rights reserved.
//

import UIKit
import DMSwipeCards

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

		self.view.backgroundColor = UIColor(white: 0.95, alpha: 1.0)

		let swipeView = DMSwipeCardsView<String>(frame: CGRect(x: 0, y: 80, width: self.view.frame.width, height: self.view.frame.height - 160)) { (element: String, frame: CGRect) -> (UIView) in
			let container = UIView(frame: CGRect(x: 30, y: 20, width: frame.width - 60, height: frame.height - 40))
			let label = UILabel(frame: container.bounds)
			label.text = element
			label.textAlignment = .center
			label.backgroundColor = UIColor.white
			label.font = UIFont.systemFont(ofSize: 48, weight: UIFontWeightThin)
			label.clipsToBounds = true
			label.layer.cornerRadius = 16
			container.addSubview(label)

			container.layer.shadowRadius = 4
			container.layer.shadowOpacity = 1.0
			container.layer.shadowColor = UIColor(white: 0.9, alpha: 1.0).cgColor
			container.layer.shadowOffset = CGSize(width: 0, height: 0)
			container.layer.shouldRasterize = true
			container.layer.rasterizationScale = UIScreen.main.scale

			return container
		}
		swipeView.addCards((1...4).map({"\($0)"}), onTop: false)
		self.view.addSubview(swipeView)

		
    }

}

