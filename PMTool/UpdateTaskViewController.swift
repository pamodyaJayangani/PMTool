//
//  UpdateTaskViewController.swift
//  PMTool
//
//  Created by Pamodya Jayangani on 5/25/19.
//  Copyright © 2019 Pamodya Jayangani. All rights reserved.
//

import UIKit
import CoreData

class UpdateTaskViewController: UIViewController {

    @IBOutlet weak var txtTastName: UITextField!
    @IBOutlet weak var txtTaskNote: UITextField!
    @IBOutlet weak var dueDate: UIDatePicker!
    @IBOutlet weak var priority: UISegmentedControl!
    
    @IBOutlet weak var addToCalendar: UISwitch!
    
    var taskName:String = ""
    var tNote: String = ""
    var taskPriority: String = ""
    var date: String = ""
    var projectName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        // Do any additional setup after loading the view.
    }
    
    
    var detailTask: Tasks? {
        didSet {
            // Update the view.
              updateView()
        }
    }
    
    
    func updateView(){
        print("**************")
      //  if let detail = detailTask {
            if let label = txtTastName{
                label.text = taskName
            }
            print(":::::::::\(taskName)")
            if let note = txtTaskNote{
                note.text = tNote
            }
 


            if let projectPiority = priority{
                var status = taskPriority
               switch status {
                case "Medium":
                    projectPiority.selectedSegmentIndex = 1
                case "High":
                    projectPiority.selectedSegmentIndex = 2
                    
                default:
                    projectPiority.selectedSegmentIndex = 0
                }
                
            }
        }
    


    @IBAction func updateTask(_ sender: Any) {
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
        let fetchRequest : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Tasks")
        fetchRequest.predicate = NSPredicate(format: "projectName = %@", (projectName))
        fetchRequest.predicate = NSPredicate(format: "taskName = %@", (taskName))
        
        do
        {
            let test = try managedContext.fetch(fetchRequest)
            
            let objectUpdate = test[0] as! NSManagedObject
            objectUpdate.setValue(txtTastName.text, forKey: "taskName")
            objectUpdate.setValue(txtTastName.text, forKey: "taskNote")
            objectUpdate.setValue(taskPriority, forKey: "priority")
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
    
    // Override to support editing the table view.
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
