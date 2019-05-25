//
//  ProjectDetailsViewController.swift
//  PMTool
//
//  Created by Pamodya Jayangani on 5/24/19.
//  Copyright © 2019 Pamodya Jayangani. All rights reserved.
//

import UIKit

class ProjectDetailsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var txtProjectName: UITextField!
    
    @IBOutlet weak var txtProjectNotes: UITextField!
    
     @IBOutlet weak var dueDate: UIDatePicker!
    
    @IBOutlet weak var priority: UISegmentedControl!
    
    @IBOutlet weak var addToCalendar: UISwitch!
    /*
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func saveProject(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newProject = Projects(context: context)
        
        var status = priority.selectedSegmentIndex
        switch status {
        case 0:
            newProject.priority = "Low"
        case 1:
            newProject.priority = "Medium"
        case 2:
            newProject.priority = "High"
        default:
            newProject.priority = "Low"
        }
        
        
        newProject.projectName = txtProjectName.text
        newProject.projectNote = txtProjectNotes.text
        if addToCalendar.isSelected{
            newProject.dueDate = String(dueDate.date.description)
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
