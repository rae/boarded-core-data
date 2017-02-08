//
//  ThreadController.swift
//  Boarded
//
//  Created by Reid Ellis on 2017-01-10.
//  Copyright © 2017 Tnir Technologies. All rights reserved.
//

import UIKit

class ThreadController: UITableViewController {

	@IBOutlet weak var detailDescriptionLabel: UILabel!
	var thread : BThread? = nil

	func configureView() {
		// Update the user interface for the detail item.
		let count = self.thread?.posts?.count ?? 0
		detailDescriptionLabel.text = "\(count)"
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		self.configureView()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	var detailItem: BPost? {
		didSet {
		    // Update the view.
		    self.configureView()
		}
	}
}

