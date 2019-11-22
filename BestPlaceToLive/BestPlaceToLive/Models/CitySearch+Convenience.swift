//
//  CitySearch+Convenience.swift
//  BestPlaceToLive
//
//  Created by Luqmaan Khan on 11/15/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import Foundation
import CoreData


extension CitySearch {
    
    convenience init(id: String, cityName: String, cityPhoto: String, parentGroup: Group, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.id = id
        self.cityName = cityName
        self.cityPhoto = cityPhoto
        self.parentGroup = parentGroup
    }
}
