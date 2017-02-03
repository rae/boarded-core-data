//
//  BBoard.swift
//  Boarded
//
//  Created by Reid Ellis on 2017-01-23.
//  Copyright © 2017 Tnir Technologies. All rights reserved.
//

import Foundation
import MagicalRecord

extension BBoard {
	class func add(dict inDict: [String:Any]) -> BBoard? {
		let board = BBoard.mr_createEntity()
		board?.add(dict:inDict)
		if let name = board?.name {
			print("Added board \(name)")
		}
		return board
	}

	func add(dict inDict: [String:Any]) {
		self.name = inDict["title"] as? String
		self.path = inDict["board"] as? String
		self.about = inDict["meta_description"] as? String
		self.boardIdentifier = inDict["board"] as? String
		if let cooldowns = inDict["cooldowns"] as? [String:Int32] {
			self.cooldownImages = cooldowns["images"] ?? 0
			self.cooldownReplies = cooldowns["replies"] ?? 0
			self.cooldownThreads = cooldowns["threads"] ?? 0
		}
		self.imageLimit = inDict["image_limit"] as? Int32 ?? 0
		self.maxFileSize = inDict["max+filesize"] as? Int32 ?? 0
		self.populateThreads()
		do {
			try self.managedObjectContext?.save()
		} catch let error as NSError  {
			print("Could not save \(error), \(error.userInfo)")
		}

	}
	func populateThreads() {
		// download threads URL
		// create entities

		// http://a.4cdn.org/b/2.json

		if let site=self.site, let path=self.path {
			site.request(api: path, completion: { (jsonDict) in
				print("dict: \(jsonDict)")
			})
		}

	}
	func add(threads:[[String:Any]]) {
		for thread in threads {
			print("Got thread \(thread)")
		}
	}

}
