//
//  SortViewController.swift
//  InterviewDankolab
//
//  Created by mac on 20.01.2022.
//

import UIKit

class SortViewController: UIViewController {

    @IBOutlet weak var sortNameBtn: UIButton!
    
    @IBOutlet weak var sortDateBtn: UIButton!
    
    @IBOutlet weak var cancelBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        cancelBtn.layer.cornerRadius = 6
        sortDateBtn.layer.cornerRadius = 6
        sortDateBtn.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        sortNameBtn.layer.cornerRadius = 6
        sortNameBtn.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        sortDateBtn.layer.borderWidth = 0.2
        sortDateBtn.layer.borderColor = UIColor.gray.cgColor
        sortNameBtn.layer.borderWidth = 0.2
        sortNameBtn.layer.borderColor = UIColor.gray.cgColor
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
