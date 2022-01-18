//
//  AnimationManager.swift
//  InterviewDankolab
//
//  Created by mac on 15.01.2022.
//

import UIKit

class AnimationManager {
    
    static var shared = AnimationManager()
    
    var animationTime = DispatchTimeInterval.seconds(Int.random(in: 2...5))
    var loadIsComplete = false
    
    var sessionNumber: Int {
        get{
            return UserDefaults.standard.integer(forKey: "session_number")
        }
        set{
            UserDefaults.standard.setValue(newValue, forKey: "session_number")
            UserDefaults.standard.synchronize()
        }
    }
    
    private init() {}
    
    func sessionCounter() {
        sessionNumber += 1
    }
    
    func animate(obj: UIImageView) {
        let animation = CABasicAnimation()
        animation.keyPath = "transform.rotation.z"
        animation.fromValue = 0
        animation.toValue = CGFloat.pi * 2
        animation.duration = 2
        animation.repeatCount = HUGE
        
        obj.layer.add(animation, forKey: "basic")
    }
    
    func loadingComlete(obj: UIImageView) {
        obj.layer.removeAllAnimations()
        obj.isHidden = true
        loadIsComplete = true
    }
    
    func appearance(obj: UIView) {
        UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseInOut, animations: {
            obj.alpha = 1
        })
    }
}
