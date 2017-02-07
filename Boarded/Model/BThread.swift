//
//  BThread.swift
//  Boarded
//
//  Created by Reid Ellis on 2017-01-23.
//  Copyright © 2017 Tnir Technologies. All rights reserved.
//

import Foundation
import MagicalRecord

extension BThread {
	class func add(dict inDict: [String:Any]) {
		let thread = BThread.mr_createEntity()
		thread?.add(dict:inDict)
	}

	func add(dict inDict: [String:Any]) {
		for(thread, threadDict) in inDict {
//			print(thread)
		}
	}

}
