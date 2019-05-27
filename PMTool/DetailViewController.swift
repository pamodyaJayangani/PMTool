//
//  DetailViewController.swift
//  PMTool
//
//  Created by Pamodya Jayangani on 5/21/19.
//  Copyright © 2019 Pamodya Jayangani. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate{
    
    var managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        var fetchRequest: NSFetchRequest<Tasks>!

    @IBOutlet weak var detailDescriptionLabel: UILabel!

    @IBOutlet weak var projectNote: UILabel!
    
    @IBOutlet weak var lblPriority: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var projectName: String = ""
    var taskName:String = ""
    var tNote: String = ""
    var tProgress:Double = 0.00
    var taskPriority: String = ""
    var date: String = ""
     let cellName:String = "Cell";
//    var arr: [String] = []
    var arr:[Tasks] = []
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = detailDescriptionLabel {
                label.text = detail.projectName!.description
                projectName = detail.projectName!.description
            }
            if let note = projectNote{
                note.text = detail.projectNote
                
            }
            if let priority = lblPriority{
                priority.text = detail.priority
               
            }
        }
        
        retrieveTaskData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        configureView()
        print("Zzzz")
       //============
//         self.taskView.register(UITableViewCell.self, forCellReuseIdentifier: self.cellName)
        tableView.delegate = self
        tableView.dataSource = self
        
        if let split = splitViewController {
            let controllers = split.viewControllers
        //    detailViewController = (controllers[controllers.count-1] as! UINavigationController9).topViewController as? DetailViewController
        }
        //====
    }

    var  detailItem: Projects? {
        didSet {
            // Update the view.
            configureView()
        }
    }


    @IBOutlet weak var taskView: UITableView!
    //========
//    override func viewWillAppear(_ animated: Bool) {
//        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
//        super.viewWillAppear(animated)
//    }
//
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showDetail" {
//            if let indexPath = tableView.indexPathForSelectedRow {
//                let object = fetchedResultsController.object(at: indexPath)
//                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
//                controller.detailItem = object
//                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
//                controller.navigationItem.leftItemsSupplementBackButton = true
//            }
//        }
//    }
//
    
//     func numberOfSections(in tableView: UITableView) -> Int {
//      // return fetchedResultsController.sections?.count ?? 0
//        return arr.count
//    }
    
    ///==========
    
    
    
    
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: (Any)?)
    {
        if segue.destination is TaskDetailsViewController
        {
            let vc = segue.destination as? TaskDetailsViewController
            vc?.projectName = projectName
        }
        print("------\(taskName)")
        if segue.destination is UpdateTaskViewController{
            let index = tableView.indexPathForSelectedRow
            getData(forRowAt: index!)
            // if segue.identifier == "UpdateTask" {
            let updateController = (segue.destination as? UpdateTaskViewController)
            updateController?.taskName = taskName
            updateController?.tNote = tNote
            updateController?.date = date
            updateController?.taskPriority = taskPriority
            updateController?.projectName = projectName
            
            //print("Update\(arr[indexPath.row])")

    }
    }
    
    func getData(forRowAt indexPath: IndexPath){
        taskName = arr[indexPath.row].taskName!
        tNote = arr[indexPath.row].taskNote!
        tProgress = arr[indexPath.row].progress
        //date = arr[indexPath.row].dueDate!
//        taskPriority = arr[indexPath.row].priority!
    }
    func retrieveTaskData(){
        
//        arr.removeAll(keepingCapacity: true)
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        print("test project name \(projectName)")
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Tasks")
        fetchRequest.predicate = NSPredicate(format: "projectName = %@", projectName)
        
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                print("AAAAAA\(data.value(forKey: "taskName") as! String)")
               arr.append(data  as! Tasks)
                
            }
            
        } catch {
            
            print("Failed")
        }
        
    }
    
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        //==
//        //let sectionInfo = fetchedResultsController.sections![section]
//        //  return sectionInfo.numberOfObjects
//        return arr.count
//        //===
//    }
    
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellName) as! UITableViewCell
//        //        cell.textLabel?.lineBreakMode = .byWordWrapping
//        //        cell.textLabel?.numberOfLines = 3
//        cell.textLabel?.text = arr[indexPath.row].taskName!
//
//        return cell
//    }
 
    // Override to support editing the table view.
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
////            tableView.deleteRows(at: [indexPath], with: .fade)
//            arr.remove(at: indexPath.row)
//            tableView.reloadData()
//
//            // Delete the row from the data source
//            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//
//            //We need to create a context from this container
//            let managedContext = appDelegate.persistentContainer.viewContext
//
//
////            getData(forRowAt: indexPath)
//
//            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Tasks")
//            fetchRequest.predicate = NSPredicate(format: "taskName = %@", taskName)
//            fetchRequest.predicate = NSPredicate(format: "projectName = %@", projectName)
//
//
//            do
//            {
//                let tasks = try managedContext.fetch(fetchRequest)
//
//                let objectToDelete = tasks[indexPath.row] as! NSManagedObject
//                managedContext.delete(objectToDelete)
//
//                do{
//                    try managedContext.save()
//                }
//                catch
//                {
//                    print(error)
//                }
//
//            }
//            catch
//            {
//                print(error)
//            }
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
//    }
    
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//
    
    
    
    
    
    
    
    
    
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        ///==
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//        let event = fetchedResultsController.object(at: indexPath)
//        configureCell(cell, withEvent: event)
//        return cell
//        //===
//
//    }
//    //=======
//     func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        // Return false if you do not want the specified item to be editable.
//        return true
//    }
//
//     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            let context = fetchedResultsController.managedObjectContext
//            context.delete(fetchedResultsController.object(at: indexPath))
//
//            do {
//                try context.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//            }
//
//
//    func configureCell(_ cell: UITableViewCell, withEvent event: Tasks) {
//        cell.textLabel!.text = "event.taskName!.description"
//    }
//
//    // MARK: - Fetched results controller
//
//    var fetchedResultsController: NSFetchedResultsController<Tasks> {
//        if _fetchedResultsController != nil {
//            return _fetchedResultsController!
//        }
//
////        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
////
////        cell.textLabel?.text = "DEF GHI POU ERT TYO ABC"
////
////        return cell
////    }
//
//        let fetchRequest: NSFetchRequest<Tasks> = Tasks.fetchRequest()
//
//        // Set the batch size to a suitable number.
//        fetchRequest.fetchBatchSize = 20
//
//        // Edit the sort key as appropriate.
//        let sortDescriptor = NSSortDescriptor(key: "taskName", ascending: false)
//
//        fetchRequest.sortDescriptors = [sortDescriptor]
//
//        // Edit the section name key path and cache name if appropriate.
//        // nil for section name key path means "no sections".
//        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: nil, cacheName: "Master")
//        aFetchedResultsController.delegate = self
//        _fetchedResultsController = aFetchedResultsController
//
//        do {
//            try _fetchedResultsController!.performFetch()
//        } catch {
//            // Replace this implementation with code to handle the error appropriately.
//            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//            let nserror = error as NSError
//            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//        }
//
//        return _fetchedResultsController!
//    }
//
//
//    var _fetchedResultsController: NSFetchedResultsController<Tasks>? = nil
//
//    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        taskView.beginUpdates()
//    }
//
//    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
//        switch type {
//        case .insert:
//            taskView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
//        case .delete:
//            taskView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
//        default:
//            return
//        }
//    }
//
//    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
//        switch type {
//        case .insert:
//            taskView.insertRows(at: [newIndexPath!], with: .fade)
//        case .delete:
//            taskView.deleteRows(at: [indexPath!], with: .fade)
//        case .update:
//            configureCell(taskView.cellForRow(at: indexPath!)!, withEvent: anObject as! Tasks)
//        case .move:
//            configureCell(taskView.cellForRow(at: indexPath!)!, withEvent: anObject as! Tasks)
//            taskView.moveRow(at: indexPath!, to: newIndexPath!)
//        }
//    }
//
//    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        taskView.endUpdates()
//    }
//
//    //=====
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.fetchedResultsController.sections?.count ?? 0
        //        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = self.fetchedResultsController.sections![section] as NSFetchedResultsSectionInfo
        return sectionInfo.numberOfObjects
        //        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",for:indexPath) as! CustomTaskTableViewCell
        self.configureCell(cell,indexPath:indexPath)
        
        
        return cell
    }
    var _fetchedResultsController: NSFetchedResultsController<Tasks>? = nil
    
    var fetchedResultsController: NSFetchedResultsController<Tasks> {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let currentProject = self.detailItem
        let request: NSFetchRequest<Tasks> = Tasks.fetchRequest()
        
        // Set the batch size to a suitable number.
        request.fetchBatchSize = 20
        
        // Edit the sort key as appropriate.
        let sortDescriptor = NSSortDescriptor(key: "taskName", ascending: true,selector:#selector(NSString.localizedStandardCompare(_:)))
        
        request.sortDescriptors = [sortDescriptor]
        
        request.predicate = NSPredicate(format: "projectName = %@", projectName)
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        
        let frc = NSFetchedResultsController<Tasks>(
            fetchRequest: request,
            managedObjectContext: managedObjectContext,
            sectionNameKeyPath: #keyPath(Tasks.projectName),
            cacheName: nil)
        frc.delegate = self
        _fetchedResultsController = frc
        
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return frc as! NSFetchedResultsController<NSFetchRequestResult> as!
            NSFetchedResultsController<Tasks>
    }
    //MARK : fetch results with table view
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
        default:
            return
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
            
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            print(tableView.cellForRow(at: indexPath!)!, newIndexPath!)
            break
        //            configureCell(tableView.cellForRow(at: indexPath!)!, indexPath: newIndexPath!)
        case .move:
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let context = fetchedResultsController.managedObjectContext
            context.delete(fetchedResultsController.object(at: indexPath))
            
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func configureCell(_ cell:UITableViewCell,indexPath:IndexPath){

        let cell = cell as! CustomTaskTableViewCell
        
        //        let taskName = self.tasks[indexPath.row].name!
        let taskName = self.fetchedResultsController.fetchedObjects?[indexPath.row].taskName
        //        let estimatedTime = self.fetchedResultsController.fetchedObjects?[indexPath.row].estTime
        let notes = self.fetchedResultsController.fetchedObjects?[indexPath.row].taskNote
        let selectedDate = self.fetchedResultsController.fetchedObjects?[indexPath.row].dueDateNew
        let progress = self.fetchedResultsController.fetchedObjects?[indexPath.row].progress
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MM-dd-yyyy"
        cell.taskDate.text = "Due \(dateFormatterPrint.string(from: selectedDate!))"
        
        if((self.fetchedResultsController.fetchedObjects?[indexPath.row]) != nil) {
            
            
            var progress = self.fetchedResultsController.fetchedObjects?[indexPath.row].progress

        }
        //
        //        let alert = UIAlertController(title:"Missing some fields",message: "Please fill values in empty fields", preferredStyle: .alert)
        //        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        //        alert.addAction(OKAction)
        //        self.present(alert,animated: true, completion: nil)
        
        print("completed")
        print(indexPath.row)
        
        cell.taskName.text = taskName
        cell.progressLbl.text = "Progress - \(String(stringInterpolationSegment: progress!))"
        //        cell.Percentage.text = String(progress!)
//        cell.taskNotes.text = notes
        //cell.progress.progress = Float(progress!/100)
        //        let taskFrame = CGRect(x: 0.0, y: 0.0, width: 350.0, height: 10.0)
        //        let taskProgress = M13ProgressViewBorderedBar.init(frame: taskFrame)
        //        taskProgress.setProgress(CGFloat(progress!)/100, animated: false)
        //
        //        cell.progressviewbar.addSubview(taskProgress)
        
        
    }
    var detailTask: Tasks? {
        didSet {
            // Update the view.
            configureView()
        }
    }
    //====
}

