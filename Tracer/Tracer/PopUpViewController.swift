//
//  PopUpViewController.swift
//  Tracer
//
//  Created by ykiimm on 15/11/2017.
//  Copyright © 2017 ykiimm. All rights reserved.
//

import UIKit
import PopupDialog

class PopUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .magenta
        
        let view = UIView()
        view.backgroundColor = .gray
        view.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        view.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - pop up dialog example
    func popupDialogExample() {
        let title = "THIS IS THE DIALOG TITLE"
        let message = "This is the message section of the popup dialog default view"
        let image = UIImage(named: "iphone-hero.jpg")
        
        let popup = PopupDialog(title: title, message: message, image: image, buttonAlignment: UILayoutConstraintAxis.horizontal, transitionStyle: PopupDialogTransitionStyle.bounceDown, gestureDismissal: true) {
            print("popup")
        }
        
        let buttonOne = CancelButton(title: "Cancel") {
            print("cancel")
        }
        let buttonTwo = DefaultButton(title: "default") {
            print("default")
        }
        let buttonThree = DefaultButton(title: "button three", height: 60, dismissOnTap: true) {
            print("button three")
        }
        popup.addButtons([buttonOne, buttonTwo, buttonThree])
        self.present(popup, animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
