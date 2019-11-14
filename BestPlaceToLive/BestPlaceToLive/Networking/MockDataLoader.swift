//
//  MockDataLoader.swift
//  BestPlaceToLive
//
//  Created by Jeffrey Santana on 11/13/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import Foundation

class MockDataLoader: NetworkDataLoader {
	var data: Data?
	var error: NetworkError?
	
	func loadData(from request: URL, completion: @escaping (Data?, Error?) -> Void) {
		DispatchQueue.global().async {
			completion(self.data, self.error)
		}
	}
	
	func loadData(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) {
		DispatchQueue.global().async {
			completion(self.data, self.error)
		}
	}
}
