//
//  ViewController.swift
//  Tracer
//
//  Created by ykiimm on 14/11/2017.
//  Copyright © 2017 ykiimm. All rights reserved.
//

import UIKit
import PopupDialog
import JTAppleCalendar


class ViewController: UIViewController {
    
    
    // MARK: - Property
    let formatter = DateFormatter()
    
    
    // MARK: - IBOutlet
    
    
    // MARK: - IBAction
    @IBAction func buttonOneAction(_ sender: Any) {
        let popupVC = PopUpViewController()
        self.present(popupVC, animated: true, completion: nil)
    }
    
    @IBAction func buttonTwoAction(_ sender: Any) {
        let title = "pop up dialog title"
        let message = "this is message. just listen."
        let popupDialog = PopupDialog(title: title, message: message)
        
        self.present(popupDialog, animated: true, completion: nil)
    }
    
    @IBAction func buttonThreeAction(_ sender: Any) {
        let title = "pop up dialog title"
        let message = "this is message. just listen."
        let image = UIImage(named: "iphone-hero.jpg")
        let secondPopupDialog = PopupDialog(title: title,
                                            message: message,
                                            image: image,
                                            buttonAlignment: UILayoutConstraintAxis.horizontal,
                                            transitionStyle: PopupDialogTransitionStyle.bounceDown,
                                            gestureDismissal: false) {
                                                print("dismissing second popup dialog")
        }
        let cancelButton = CancelButton(title: "Cancel",
                                        height: 100,
                                        dismissOnTap: true) {
                                            print("cancel")
        }
        let okButton = DefaultButton(title: "OK",
                                     height: 100,
                                     dismissOnTap: true) {
                                        print("OK")
        }
        secondPopupDialog.addButtons([cancelButton, okButton])
        self.present(secondPopupDialog, animated: true, completion: nil)
    }
    
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension ViewController: JTAppleCalendarViewDataSource {
   
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        let startDate = formatter.date(from: "2017 01 01")!
        let endDate = formatter.date(from: "2017 12 31")!
        
        let parameter = ConfigurationParameters(startDate: startDate, endDate: endDate)
        return parameter
    }
}

extension ViewController: JTAppleCalendarViewDelegate {

    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let customCell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "customCell", for: indexPath) as! CustomCell
        customCell.dateLabel.text = cellState.text
        return customCell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        let customCell = cell as! CustomCell
        customCell.dateLabel.text = cellState.text
        
    }
}

