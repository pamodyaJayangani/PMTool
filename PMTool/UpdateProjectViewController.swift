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
                
                let projectDate: NSDate? = dateFormatterPrint.date(from: "May 24 2019") as! NSDate

                date.date = projectDate as! Date
            }
            if let projectPiority = priority{
                var status = detail.priority
                switch status {
                case "Medium":
                    projectPiority.selectedSegmentIndex = 1
                case "High":
                    projectPiority.selectedSegmentIndex = 2
                    
                default:
                    projectPiority.selectedSegmentIndex = 3
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
        
        /*Read data from fields*/
        
        var status = priority.selectedSegmentIndex
        var projectPriority = ""
        
        switch status {
        case 0:
            projectPriority = "Low"
        case 1:
            projectPriority = "Medium"
        case 2:
            projectPriority = "High"
        default:
            projectPriority = "Low"
        }
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Projects")
        fetchRequest.predicate = NSPredicate(format: "projectName = %@", (detailItems?.projectName!)!)

        do
        {
            let test = try managedContext.fetch(fetchRequest)
            
            let objectUpdate = test[0] as! NSManagedObject
            objectUpdate.setValue(txtProjectName.text, forKey: "projectName")
            objectUpdate.setValue(txtProjectNotes.text, forKey: "projectNote")
            objectUpdate.setValue(projectPriority, forKey: "priority")
            objectUpdate.setValue(String(dueDate.date.description), forKey: "dueDate")
            do{
                try managedContext.save()
            }
            catch
            {
                print(error)
            }
        }
        catch
        {
            print(error)
        }
        dismiss(animated: true)
    }
}
