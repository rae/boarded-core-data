//
//  BSite+CoreDataProperties.swift
//  
//
//  Created by Reid Ellis on 2017-01-20.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension BSite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BSite> {
        return NSFetchRequest<BSite>(entityName: "BSite");
    }

    @NSManaged public var about: String?
    @NSManaged public var apiURLString: String?
    @NSManaged public var boardsPartialPath: String?
    @NSManaged public var lastVisit: NSDate?
    @NSManaged public var name: String?
    @NSManaged public var urlString: String?
    @NSManaged public var authors: NSSet?
    @NSManaged public var boards: NSSet?

}

// MARK: Generated accessors for authors
extension BSite {

    @objc(addAuthorsObject:)
    @NSManaged public func addToAuthors(_ value: BPerson)

    @objc(removeAuthorsObject:)
    @NSManaged public func removeFromAuthors(_ value: BPerson)

    @objc(addAuthors:)
    @NSManaged public func addToAuthors(_ values: NSSet)

    @objc(removeAuthors:)
    @NSManaged public func removeFromAuthors(_ values: NSSet)

}

// MARK: Generated accessors for boards
extension BSite {

    @objc(addBoardsObject:)
    @NSManaged public func addToBoards(_ value: BBoard)

    @objc(removeBoardsObject:)
    @NSManaged public func removeFromBoards(_ value: BBoard)

    @objc(addBoards:)
    @NSManaged public func addToBoards(_ values: NSSet)

    @objc(removeBoards:)
    @NSManaged public func removeFromBoards(_ values: NSSet)

}
