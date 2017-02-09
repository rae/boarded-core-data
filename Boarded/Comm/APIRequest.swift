//
//  APIRequest.swift
//  Boarded
//
//  Created by Reid Ellis on 2017-02-09.
//  Copyright © 2017 Tnir Technologies. All rights reserved.
//

import Foundation

class APIRequest {
	var apiBaseURLString = ""
	var apiString = ""
	var suffix = ""

	init(urlString: String, apiString: String = "", suffix: String = ".json") {
		self.apiBaseURLString = urlString
		self.apiString = apiString
		self.suffix = suffix
	}

	func request(completion: @escaping ([String:Any])-> Void) {
		self.request(api: self.apiString, completion: completion)
	}

	func request(api: String, completion: @escaping ([String:Any])-> Void) {
		let urlString = "\(self.apiBaseURLString)/\(api)\(self.suffix)"
		let apiURL = URL(string: urlString)!

		let config = URLSessionConfiguration.default
		config.timeoutIntervalForRequest = 5
		config.timeoutIntervalForResource = 10
		let session = URLSession(configuration: config)

		NSLog("APIRequest: Calling API \(urlString)")
		let task = session.dataTask(with: apiURL) { (data, response, error) in
			if response == nil {
				print("no response")
			}
			guard error == nil, let data=data else {
				if(error != nil) {
					print("\(error)")
				}
				return
			}
			do {
				let json = try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments)
				let dict = json as! [String:Any]
				completion(dict)
			} catch {
				completion([:])
			}
		}

		task.resume();
	}
}
