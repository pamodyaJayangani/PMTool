//
//  TaskDetailsViewController.swift
//  PMTool
//
//  Created by Pamodya Jayangani on 5/24/19.
//  Copyright © 2019 Pamodya Jayangani. All rights reserved.
//

import UIKit

class TaskDetailsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBOutlet weak var txtTaskName: UITextField!
    
    @IBOutlet weak var txtTaskNote: UITextField!
    
    @IBOutlet weak var dueDate: UIDatePicker!
    
    @IBOutlet weak var priority: UISegmentedControl!
    
    @IBOutlet weak var addToCalendar: UISwitch!
    
    var projectName = ""
    
    @IBAction func saveTasks(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newTask = Tasks(context: context)
        
        newTask.projectName = projectName
        var status = priority.selectedSegmentIndex
        switch status {
        case 0:
            newTask.priority = "Low"
        case 1:
            newTask.priority = "Medium"
        case 2:
            newTask.priority = "High"
        default:
            newTask.priority = "Low"
        }
        
        
        //newTask.projectName = txtProjectName.text
        newTask.taskName = txtTaskName.text           
        newTask.taskNote = txtTaskNote.text
        if addToCalendar.isSelected{
            newTask.dueDate = String(dueDate.date.description)
        }
        //Save the context.
        do{
            //  print("!!!!!!!!!!!!")
            try context.save()
        }catch{
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror)")
        }
        dismiss(animated: true)
    }
    
    
    
    
}
