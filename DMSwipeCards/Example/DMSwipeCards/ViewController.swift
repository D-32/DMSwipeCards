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
			let label = UILabel(frame: CGRect(x: 30, y: 20, width: frame.width - 60, height: frame.height - 40))
			label.text = element
			label.textAlignment = .center
			label.backgroundColor = UIColor.white
			label.font = UIFont.systemFont(ofSize: 48, weight: UIFontWeightThin)
			label.clipsToBounds = false
			label.layer.cornerRadius = 16
			label.layer.shadowRadius = 4
			label.layer.shadowOpacity = 0.1
			label.layer.shadowOffset = CGSize(width: 0, height: 0)
			return label
		}
		swipeView.addCards([1, 2, 3, 4].map({"\($0)"}), onTop: false)
		self.view.addSubview(swipeView)

		
    }

}

