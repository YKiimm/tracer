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


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    // MARK: - Property
//    let outsideMonthColor = UIColor(colorWithHexValue: 0x584a66)
    let outsideMonthColor = UIColor.lightGray
    let monthColor = UIColor.white
    let selectedMonthColor = UIColor(colorWithHexValue: 0x3a294b)
    let currentDateSelecteViewColor = UIColor(colorWithHexValue: 0x4e3f5d)
    let formatter = DateFormatter()
    
    
    // MARK: - IBOutlet
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var month: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - IBAction
 
    
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCalendarView()
        setupCalendarView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Method
    func setupCalendarView() {
        // setup calendar line
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
        calendarView.visibleDates { (visibleDates) in
            self.setupViewsOfCalendar(from: visibleDates)
        }
    }
    
    func setupViewsOfCalendar(from visibleDates: DateSegmentInfo) {
        calendarView.visibleDates { (visibleDates) in
            let date = visibleDates.monthDates.first!.date
            
            self.formatter.dateFormat = "yyyy"
            self.year.text = self.formatter.string(from: date)
            
            self.formatter.dateFormat = "MMMM"
            self.month.text = self.formatter.string(from: date)
        }
    }
    
    func handleCellTextcolor(view: JTAppleCell?, cellState: CellState) {
        guard let validCell = view as? CustomCell else { return }
        if validCell.isSelected {
            validCell.dateLabel.textColor = selectedMonthColor
        } else {
            if cellState.dateBelongsTo == .thisMonth {
                validCell.dateLabel.textColor = monthColor
            } else {
                validCell.dateLabel.textColor = outsideMonthColor
            }
        }
    }
    
    func handleCellSelected(view: JTAppleCell?, cellState: CellState) {
        let validCell = view as! CustomCell
        if cellState.isSelected {
            validCell.selectedView.isHidden = false
        } else {
            validCell.selectedView.isHidden = true
        }
    }
    
    
    // MARK: - TableView Method
    var cellText = ["cell1", "cell2", "cell3", "cell4", "cell5", "cell6", "cell7", "cell8", "cell9", "cell10", "cell11", "cell12", "cell13", "cell14", "cell15", "cell16", ]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellText.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = cellText[indexPath.row]
        cell.textLabel?.text = item
        return cell
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
        handleCellSelected(view: customCell, cellState: cellState)
        handleCellTextcolor(view: customCell, cellState: cellState)
        return customCell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        let customCell = cell as! CustomCell
        customCell.dateLabel.text = cellState.text
//        handleCellSelected(view: customCell, cellState: cellState)
//        handleCellTextcolor(view: customCell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleCellSelected(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleCellSelected(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        setupViewsOfCalendar(from: visibleDates)
    }
    
}


extension UIColor {
    convenience init(colorWithHexValue value: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((value & 0xFF0000) >> 16) / 255,
            green: CGFloat((value & 0x00FF00) >> 8) / 255,
            blue: CGFloat((value & 0x0000FF)) / 255,
            alpha: alpha
        )
    }
}
