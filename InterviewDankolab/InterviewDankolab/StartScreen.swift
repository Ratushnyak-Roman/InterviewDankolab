//
//  StartScreen.swift
//  InterviewDankolab
//
//  Created by mac on 15.01.2022.
//

import UIKit

class StartScreen: UIViewController {
    
    let animationManager = AnimationManager.shared
    var timer = Timer()
    
    @IBOutlet weak var loader: UIImageView!
    @IBOutlet weak var appName: UIImageView!
    @IBOutlet weak var appLogo: UIImageView!
    @IBOutlet weak var startBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        
        AnimationManager.shared.animate(obj: loader)
        DispatchQueue.main.asyncAfter(deadline: .now() + animationManager.animationTime, execute: {
            self.animationManager.loadingComlete(obj: self.loader)
        })
    }
    
    func setupUI() {
        appName.alpha = 0
        appLogo.alpha = 0
        startBtn.alpha = 0
        
        startBtn.layer.cornerRadius = 6
    }
    
    @objc func update() {
        guard animationManager.loadIsComplete else { return }
        timer.invalidate()
        guard animationManager.sessionNumber <= 1 else {
            let vc = storyboard?.instantiateViewController(identifier: "NC")
            self.present(vc!, animated: true, completion: nil)
            return
        }
        DispatchQueue.main.async { [self] in
            animationManager.appearance(obj: appName)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: { [self] in
            animationManager.appearance(obj: appLogo)
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: { [self] in
            animationManager.appearance(obj: startBtn)
        })
    }
}


