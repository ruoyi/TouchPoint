//
//  ViewController.swift
//  TouchPoint
//
//  Created by ruoyi on 22/01/2018.
//  Copyright © 2018 ruoyi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var gestureLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gestureLabel.isUserInteractionEnabled = true
        let tapGestureLabl = UITapGestureRecognizer(target: self, action: #selector(alert(_:)))
        gestureLabel.addGestureRecognizer(tapGestureLabl)
    }

    
    @IBAction func alert(_ sender: Any) {
        let alert = UIAlertController(title: "系统弹框", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        alert.addAction(UIAlertAction(title: "确定", style: UIAlertActionStyle.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

