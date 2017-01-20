//
//  BSite+CoreDataClass.swift
//  
//
//  Created by Reid Ellis on 2017-01-20.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData

@objc(BSite)
public class BSite: NSManagedObject {
	class func add(dict inDict: [String:Any]) {
		BSite * site = [BSite MR_createEntity];
		site.add(dict:inDict)
	}

	func add(dict inDict: [String:Any]) {
		for(board, boardDict) in inDict {
			print(board)

		}
	}
}
