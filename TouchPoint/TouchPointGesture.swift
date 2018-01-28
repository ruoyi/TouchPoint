//
//  TouchPointGesture.swift
//  TouchPoint
//
//  Created by ruoyi on 22/01/2018.
//  Copyright © 2018 ruoyi. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass


class TouchPointGesture: UIGestureRecognizer {

    fileprivate var dotViews = [Int: DotView]()
    
    fileprivate let dotWidth: CGFloat
    fileprivate let dotColor: UIColor
    
    init(dotWidth: CGFloat = 20, dotColor: UIColor = UIColor.init(red: 30/255, green: 144/255, blue: 1, alpha: 1)) {
        self.dotWidth = dotWidth
        self.dotColor = dotColor
        super.init(target: nil, action: nil)
        self.delegate = self
        delaysTouchesBegan = false
        delaysTouchesEnded = false
        cancelsTouchesInView = false
    }

    fileprivate func handle(touches: Set<UITouch>, event: UIEvent, isPress: Bool = false) {
        touches.forEach { (touch) in
            
            switch touch.phase {
            case .began:
                let dotView = DotView(frame: CGRect(x: 0, y: 0, width: 20, height: 20), color: dotColor)
                dotView.center = touch.location(in: touch.window)
                dotViews[touch.hashValue] = dotView
                touch.window?.addSubview(dotView)
            case .moved:
                if let dotView = dotViews[touch.hashValue] {
                    dotView.center = touch.location(in: touch.window)
                }
            case .stationary:
                break
            case .ended, .cancelled:
                if let dotView = dotViews[touch.hashValue] {
                    dotView.removeFromSuperview()
                    dotViews.removeValue(forKey: touch.hashValue)
                }
            }
        }
    }
    
}

// MARK:- UIGestureRecognizerDelegate
extension TouchPointGesture: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive press: UIPress) -> Bool {
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}

// MARK:- Override UIGestureRecognizerSubclass
extension TouchPointGesture {
    
    override func canBePrevented(by preventingGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
    override func shouldBeRequiredToFail(by otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        handle(touches: touches, event: event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        handle(touches: touches, event: event)

    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        handle(touches: touches, event: event)

    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        handle(touches: touches, event: event)
    }
}


// MARK:- DotView
fileprivate class DotView: UIView {
    
    init(frame: CGRect, color: UIColor = .blue) {
        super.init(frame: frame)
        backgroundColor = color
        layer.cornerRadius = frame.size.width/2
        
    }
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        let view = UIView()
        insertSubview(view, at: 0)
        view.frame = bounds
        view.layer.cornerRadius = view.frame.size.width/2
        view.backgroundColor = backgroundColor
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
            view.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            view.alpha = 0
        }) { (_) in
            view.removeFromSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}





