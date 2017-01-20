//
//  BPerson+CoreDataProperties.swift
//  
//
//  Created by Reid Ellis on 2017-01-20.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension BPerson {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BPerson> {
        return NSFetchRequest<BPerson>(entityName: "BPerson");
    }

    @NSManaged public var identifier: String?
    @NSManaged public var lastSeen: NSDate?
    @NSManaged public var name: String?
    @NSManaged public var posts: BPost?
    @NSManaged public var site: BSite?

}
