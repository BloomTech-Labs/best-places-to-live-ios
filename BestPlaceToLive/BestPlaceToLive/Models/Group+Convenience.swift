//
//  Group+Convenience.swift
//  BestPlaceToLive
//
//  Created by Bradley Yin on 11/20/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import Foundation
import CoreData

extension Group {
    
    convenience init(name: String, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.name = name
    }
}
