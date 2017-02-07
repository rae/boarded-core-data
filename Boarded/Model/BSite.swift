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
	class func load4chan() {
		let scheme = "https://"
		let ext = ".json" // could be xml or something in future?
		let apiURLString = scheme + "a.4cdn.org"
		let boardsApiUrlString = apiURLString + "/boards" + ext
		let boardsURL = URL(string: boardsApiUrlString)!
		//		let req = URLRequest(url: boardsURL)
		let session = URLSession.shared;
		NSLog("Got session \(session)")
		let task = URLSession.shared.dataTask(with: boardsURL) { (data, response, error) in
			guard error == nil, let data=data else {
				return
			}
			do {
				let json = try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments)
				let dict = json as! [String:Any]
				let boards = dict["boards"] as! [[String:Any]]
				BSite.add(boards:boards, name:"4Chan")
			} catch let error {
				print(error)
			}
		}
		task.resume();
	}

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
		for callback in BBoard.callbacks {
			callback()
		}
	}

	func request(api: String, completion: @escaping ([String:Any])-> Void) {
		let urlString = "\(self.apiURLString)/\(api).json"
		let apiURL = URL(string: urlString)!
		let task = URLSession.shared.dataTask(with: apiURL) { (data, response, error) in
			guard error == nil, let data=data else {
				return
			}
			do {
				let json = try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments)
				let dict = json as! [String:Any]
				completion(dict)
			} catch let error {
				completion([:])
			}
		}
		task.resume();
	}
}
