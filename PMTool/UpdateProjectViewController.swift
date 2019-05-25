//
//  UpdateProjectViewController.swift
//  PMTool
//
//  Created by Pamodya Jayangani on 5/24/19.
//  Copyright © 2019 Pamodya Jayangani. All rights reserved.
//

import UIKit
import CoreData

class UpdateProjectViewController: UIViewController {
    
    @IBOutlet weak var txtProjectName: UITextField!
    
    @IBOutlet weak var txtProjectNotes: UITextField!
    
    @IBOutlet weak var dueDate: UIDatePicker!
    
    @IBOutlet weak var priority: UISegmentedControl!
    
    @IBOutlet weak var addToCalendar: UISwitch!
    
    func updateView(){
        if let detail = detailItems {
            if let label = txtProjectName{
                label.text = detail.projectName!
            }
            if let note = txtProjectNotes{
                note.text = detail.projectNote!
            }
            if let date = dueDate{
                let dateFormatterPrint = DateFormatter()
                dateFormatterPrint.dateFormat = "MMM dd,yyyy"
                
                let projectDate: NSDate? = dateFormatterPrint.date(from: "May 25 2019") as! NSDate

                date.date = projectDate as! Date
            }
            if let projectPiority = priority{
                var status = detail.priority
                switch status {
                case "Medium":
                    projectPiority.isEnabledForSegment(at: 1)
                case "High":
                    projectPiority.isEnabledForSegment(at: 2)
                
                default:
                    projectPiority.isEnabledForSegment(at: 0)
                }
                
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        // Do any additional setup after loading the view.
    }
    
    
   
    
    var  detailItems: Projects? {
        didSet {
            // Update the view.
            updateView()
        }
    }
    
    
    
    
    
    @IBAction func updateProject(_ sender: Any) {
    }
}
