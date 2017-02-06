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
	var boards : [BBoard] = []

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		self.navigationItem.leftBarButtonItem = self.editButtonItem

		if let split = self.splitViewController {
		    let controllers = split.viewControllers
		    self.threadController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? ThreadController
		}
		self.reload()
		let myCallback = {
			self.reload
		}

		BBoard.callbacks.append(myCallback())
		print("callback count: \(BBoard.callbacks.count)")
	}

	func reload() {
		self.boards = BBoard.mr_findAll() as! [BBoard]
		self.tableView.reloadData()
	}

	override func viewWillAppear(_ animated: Bool) {
		self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
		super.viewWillAppear(animated)
	}

	// MARK: - Table View

	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.boards.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		let board = self.boards[indexPath.row]
		self.configureCell(cell, withBoard: board)
		return cell
	}

	override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		// Return false if you do not want the specified item to be editable.
		return false
	}

	func configureCell(_ cell: UITableViewCell, withBoard board: BBoard) {
		if let desc=board.name, let title=board.boardIdentifier {
			cell.textLabel!.text = title // thread.timestamp!.description
			cell.detailTextLabel?.text = desc
		}
	}

	// MARK: - Fetched results controller


}

