//
//  BBoard+CoreDataProperties.swift
//  
//
//  Created by Reid Ellis on 2017-01-20.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension BBoard {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BBoard> {
        return NSFetchRequest<BBoard>(entityName: "BBoard");
    }

    @NSManaged public var about: String?
    @NSManaged public var name: String?
    @NSManaged public var path: String?
    @NSManaged public var site: BSite?
    @NSManaged public var threads: NSSet?

}

// MARK: Generated accessors for threads
extension BBoard {

    @objc(addThreadsObject:)
    @NSManaged public func addToThreads(_ value: BThread)

    @objc(removeThreadsObject:)
    @NSManaged public func removeFromThreads(_ value: BThread)

    @objc(addThreads:)
    @NSManaged public func addToThreads(_ values: NSSet)

    @objc(removeThreads:)
    @NSManaged public func removeFromThreads(_ values: NSSet)

}
