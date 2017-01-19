//
//  MasterViewController.swift
//  Boarded
//
//  Created by Reid Ellis on 2017-01-10.
//  Copyright © 2017 Tnir Technologies. All rights reserved.
//

import UIKit
import CoreData

class BoardController: UITableViewController, NSFetchedResultsControllerDelegate {

	var threadController: ThreadController? = nil
	var managedObjectContext: DBRef? = nil
	var site: BSite? = nil

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		self.navigationItem.leftBarButtonItem = self.editButtonItem

		let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewButton(_:)))
		self.navigationItem.rightBarButtonItem = addButton
		if let split = self.splitViewController {
		    let controllers = split.viewControllers
		    self.threadController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? ThreadController
		}
		self.managedObjectContext?.performAndWait {
			let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "BBoard")
			fetchRequest.predicate = nil
			fetchRequest.resultType = NSFetchRequestResultType.countResultType
			do {
				if let count = try self.managedObjectContext?.count(for: fetchRequest) {
					
				}
			} catch {
				//Assert or handle exception gracefully
			}

		}
//		guard let _ = self.site.urlString else {
			self.load4chan()
//			return
//		}
	}

	func load4chan() {
//		let scheme = "https://"
//		let ext = ".json" // could be xml or something in future?
//		self.site = NSEntityDescription.insertNewObject(forEntityName: "BSite", into: self.managedObjectContext!) as! BSite
//		self.site!.apiURLString = scheme + "a.4cdn.org"
//		let boardsApiUrlString = self.site!.apiURLString! + "/boards" + ext
//		let boardsURL = URL(string: boardsApiUrlString)!
////		let req = URLRequest(url: boardsURL)
//		let session = URLSession(configuration: URLSessionConfiguration.background(withIdentifier: "ca.tnir.boarded"))
//
//		let _ = session.dataTask(with: boardsURL) { (data, response, error) in
//			guard error == nil, data != nil else {
//				return
//			}
//			let str = String(data:data!, encoding: .utf8)
//			NSLog("data is \(str)")
//		}

	}

	override func viewWillAppear(_ animated: Bool) {
		self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
		super.viewWillAppear(animated)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func insertNewButton(_ sender: Any) {
		let context = self.fetchedResultsController.managedObjectContext

		// Save the context.
		do {
		    try context.save()
		} catch {
		    // Replace this implementation with code to handle the error appropriately.
		    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
		    let nserror = error as NSError
		    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
		}
	}

	// MARK: - Segues

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "showDetail" {
		    if let indexPath = self.tableView.indexPathForSelectedRow {
		    let object = self.fetchedResultsController.object(at: indexPath)
		        let controller = (segue.destination as! UINavigationController).topViewController as! ThreadController
//		        controller.detailItem = object
		        controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
		        controller.navigationItem.leftItemsSupplementBackButton = true
		    }
		}
	}

	// MARK: - Table View

	override func numberOfSections(in tableView: UITableView) -> Int {
		return self.fetchedResultsController.sections?.count ?? 0
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let sectionInfo = self.fetchedResultsController.sections![section]
		return sectionInfo.numberOfObjects
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		let thread = self.fetchedResultsController.object(at: indexPath)
		self.configureCell(cell, withThread: thread)
		return cell
	}

	override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		// Return false if you do not want the specified item to be editable.
		return true
	}

	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
		    let context = self.fetchedResultsController.managedObjectContext
		    context.delete(self.fetchedResultsController.object(at: indexPath))
		        
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

	func configureCell(_ cell: UITableViewCell, withThread thread: BThread) {
		cell.textLabel!.text = "thread \(thread)" // thread.timestamp!.description
	}

	// MARK: - Fetched results controller

	var fetchedResultsController: NSFetchedResultsController<BThread> {
	    if _fetchedResultsController != nil {
	        return _fetchedResultsController!
	    }
	    
	    let fetchRequest: NSFetchRequest<BThread> = BThread.fetchRequest()
	    
	    // Set the batch size to a suitable number.
	    fetchRequest.fetchBatchSize = 20
	    
	    // Edit the sort key as appropriate.
	    let sortDescriptor = NSSortDescriptor(key: "timestamp", ascending: false)
	    
	    fetchRequest.sortDescriptors = [sortDescriptor]
	    
	    // Edit the section name key path and cache name if appropriate.
	    // nil for section name key path means "no sections".
	    let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: nil, cacheName: "Master")
	    aFetchedResultsController.delegate = self
	    _fetchedResultsController = aFetchedResultsController
	    
	    do {
	        try _fetchedResultsController!.performFetch()
	    } catch {
	         // Replace this implementation with code to handle the error appropriately.
	         // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
	         let nserror = error as NSError
	         fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
	    }
	    
	    return _fetchedResultsController!
	}    
	var _fetchedResultsController: NSFetchedResultsController<BThread>? = nil

	func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
	    self.tableView.beginUpdates()
	}

	func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
	    switch type {
	        case .insert:
	            self.tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
	        case .delete:
	            self.tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
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
	            self.configureCell(tableView.cellForRow(at: indexPath!)!, withThread: anObject as! BThread)
	        case .move:
	            tableView.moveRow(at: indexPath!, to: newIndexPath!)
	    }
	}

	func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
	    self.tableView.endUpdates()
	}

	/*
	 // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed.
	 
	 func controllerDidChangeContent(controller: NSFetchedResultsController) {
	     // In the simplest, most efficient, case, reload the table view.
	     self.tableView.reloadData()
	 }
	 */

}

