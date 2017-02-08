//
//  BoardController.swift
//  Boarded
//
//  Created by Reid Ellis on 2017-01-10.
//  Copyright © 2017 Tnir Technologies. All rights reserved.
//

import UIKit
import CoreData

class BoardController: UITableViewController {

	var threadController: ThreadController? = nil
	var managedObjectContext: DBRef? = nil
	var boards : [BBoard] = []
	let stubs = ["fred", "ginger", "maryanne", "gilligan"]
	enum Sections : Int { case boards, stubs, count }
	let shouldUseStubs = false
	let activityView = UIActivityIndicatorView(activityIndicatorStyle: .gray)

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		self.navigationItem.leftBarButtonItem = self.editButtonItem

		if let split = self.splitViewController {
		    let controllers = split.viewControllers
		    self.threadController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? ThreadController
		}

		self.view.addSubview(self.activityView)
		self.activityView.frame = self.view.bounds
		self.activityView.startAnimating()
		self.reload()

		BBoard.callbacks.append({
			self.activityView.stopAnimating()
			self.activityView.removeFromSuperview()
			self.reload()
		})
		print("callback count: \(BBoard.callbacks.count)")
	}

	func reload() {
		let boards = BBoard.mr_findAll() as! [BBoard]
		// would be better to use mr_findAllSorted but no joy
		self.boards = boards.sorted(by: { (board1, board2) -> Bool in
			return board1.boardIdentifier! < board2.boardIdentifier!
		})
		DispatchQueue.main.async{
			self.tableView.reloadData()
		}
	}

	override func viewWillAppear(_ animated: Bool) {
		self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
		super.viewWillAppear(animated)
	}

	// MARK: - Table View

	override func numberOfSections(in tableView: UITableView) -> Int {
		return self.shouldUseStubs ? Sections.count.rawValue : 1
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if let theSection = Sections(rawValue: section) {
			switch theSection {
			case .boards:
				return self.boards.count
			case .stubs:
				return stubs.count
			default:
				return 0
			}
		}
		return 0
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "BoardCell", for: indexPath) as! BoardCell
		if let theSection = Sections(rawValue: indexPath.section) {
			switch theSection {
			case .boards:
				let board = self.boards[indexPath.row]
				self.configureCell(cell, withBoard: board)
			case .stubs:
				cell.boardName?.text = "boardName \(stubs[indexPath.row])"
				cell.boardDescription?.text = "boardDescription \(stubs[indexPath.row])"
			default:
				break
			}
		}
		return cell
	}

	override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		// Return false if you do not want the specified item to be editable.
		return false
	}

	func configureCell(_ cell: BoardCell, withBoard board: BBoard) {
		if let desc=board.name, let title=board.boardIdentifier {
			NSLog("Setting \"\(title)\"")
			cell.boardName?.text = title // thread.timestamp!.description
			cell.boardDescription?.text = desc
		}
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if(segue.identifier == "showThreads") {
			guard let threads:ThreadController = sender as? ThreadController else {
				return
			}
			threads.thread = nil
//			threads.thread =
		}
	}
}

