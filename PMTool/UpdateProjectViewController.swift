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
    
    
    func updateView(){
        
        if let detail = detailItems {
            print("======\(detail.projectName)")
            txtProjectName.text = detail.projectName
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("-------")
updateView()
        // Do any additional setup after loading the view.
    }
    
    
    @IBOutlet weak var txtProjectName: UITextField!
    
    @IBOutlet weak var txtProjectNotes: UITextField!
    
    @IBOutlet weak var dueDate: UIDatePicker!
    
    @IBOutlet weak var priority: UISegmentedControl!
    
    @IBOutlet weak var addToCalendar: UISwitch!
    
    var  detailItems: Projects? {
        didSet {
            // Update the view.
            updateView()
        }
    }
    
    
    
    @IBAction func updateProject(_ sender: Any) {
    }
}
