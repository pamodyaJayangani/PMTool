//
//  ProjectDetailsViewController.swift
//  PMTool
//
//  Created by Pamodya Jayangani on 5/24/19.
//  Copyright © 2019 Pamodya Jayangani. All rights reserved.
//

import UIKit
import EventKit

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
    
    let store = EKEventStore()
    
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
        newProject.dueDateNew = dueDate.date
        
        if addToCalendar.isOn{
             createEventinTheCalendar(with: txtProjectName.text!, forDate: dueDate.date, toDate: dueDate.date)
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
    
    func createEventinTheCalendar(with title:String, forDate eventStartDate:Date, toDate eventEndDate:Date) {
        print(title)
        print(eventStartDate)
        print(eventEndDate)
        store.requestAccess(to: .event) { (success, error) in
            if  error == nil {
                let event = EKEvent.init(eventStore: self.store)
                event.title = title
                event.calendar = self.store.defaultCalendarForNewEvents // this will return deafult calendar from device calendars
                event.startDate = eventStartDate
                event.endDate = eventEndDate
                
                let alarm = EKAlarm.init(absoluteDate: Date.init(timeInterval: -3600, since: event.startDate))
                event.addAlarm(alarm)
                
                do {
                    try self.store.save(event, span: .thisEvent)
                    //event created successfullt to default calendar
                } catch let error as NSError {
                    print("failed to save event with error : \(error)")
                }
                
            } else {
                //we have error in getting access to device calnedar
                print("error = \(String(describing: error?.localizedDescription))")
            }
        }
    }
    
    

}
