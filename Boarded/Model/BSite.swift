//
//  BSite.swift
//  Boarded
//
//  Created by Reid Ellis on 2017-01-23.
//  Copyright © 2017 Tnir Technologies. All rights reserved.
//

import Foundation
import MagicalRecord

extension BSite {
	class func add(boards: [[String:Any]], name: String) {
		let site = BSite.mr_createEntity()
		site?.name = name
		site?.add(boards:boards)
	}

	func add(boards:[[String:Any]]) {
		for boardDict in boards {
			let board = BBoard.add(dict: boardDict)
			board?.site = self
		}
	}
}
