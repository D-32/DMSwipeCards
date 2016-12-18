//
//  DMSwipeCard.swift
//  Pods
//
//  Created by Dylan Marriott on 18/12/16.
//
//

import Foundation
import UIKit

protocol DMSwipeCardDelegate: class {
	func cardSwipedLeft(_ card: DMSwipeCard)
	func cardSwipedRight(_ card: DMSwipeCard)
}

class DMSwipeCard: UIView {

	weak var delegate: DMSwipeCardDelegate?

	private let actionMargin: CGFloat = 120.0
	private let rotationStrength: CGFloat = 320.0
	private let rotationAngle: CGFloat = CGFloat(M_PI) / CGFloat(8.0)
	private let rotationMax: CGFloat = 1
	private let scaleStrength: CGFloat = -2
	private let scaleMax: CGFloat = 1.02

	private var xFromCenter: CGFloat = 0.0
	private var yFromCenter: CGFloat = 0.0
	private var originalPoint = CGPoint.zero

	override init(frame: CGRect) {
		super.init(frame: frame)

		let panGesture = UIPanGestureRecognizer(target: self, action: #selector(dragEvent(gesture:)))
		panGesture.delegate = self
		self.addGestureRecognizer(panGesture)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func dragEvent(gesture: UIPanGestureRecognizer) {
		xFromCenter = gesture.translation(in: self).x
		yFromCenter = gesture.translation(in: self).y

		switch gesture.state {
		case .began:
			self.originalPoint = self.center
			break
		case .changed:
			let rStrength = min(xFromCenter / self.rotationStrength, rotationMax)
			let rAngle = self.rotationAngle * rStrength
			let scale = min(1 - fabs(rStrength) / self.scaleStrength, self.scaleMax)
			self.center = CGPoint(x: self.originalPoint.x + xFromCenter, y: self.originalPoint.y + yFromCenter)
			let transform = CGAffineTransform(rotationAngle: rAngle)
			let scaleTransform = transform.scaledBy(x: scale, y: scale)
			self.transform = scaleTransform
			//self.updateOverlay(xFromCenter)
			break
		case .ended:
			self.afterSwipeAction()
			break
		default:
			break
		}
	}

	private func afterSwipeAction() {
		if xFromCenter > actionMargin {
			self.rightAction()
		} else if xFromCenter < -actionMargin {
			self.leftAction()
		} else {
			UIView.animate(withDuration: 0.3) {
				self.center = self.originalPoint
				self.transform = CGAffineTransform.identity

			}
		}
	}

	private func rightAction() {
		let finishPoint = CGPoint(x: 500, y: 2 * yFromCenter + self.originalPoint.y)
		UIView.animate(withDuration: 0.3, animations: { 
			self.center = finishPoint
		}) { _ in
			self.removeFromSuperview()
		}
		self.delegate?.cardSwipedRight(self)
	}

	private func leftAction() {
		let finishPoint = CGPoint(x: -500, y: 2 * yFromCenter + self.originalPoint.y)
		UIView.animate(withDuration: 0.3, animations: {
			self.center = finishPoint
		}) { _ in
			self.removeFromSuperview()
		}
		self.delegate?.cardSwipedLeft(self)
	}
}

extension DMSwipeCard: UIGestureRecognizerDelegate {
	func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
		return true
	}
}
