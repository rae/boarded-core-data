//
//  BPost+CoreDataProperties.swift
//  
//
//  Created by Reid Ellis on 2017-01-20.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension BPost {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BPost> {
        return NSFetchRequest<BPost>(entityName: "BPost");
    }

    @NSManaged public var idString: String?
    @NSManaged public var text: String?
    @NSManaged public var textType: String?
    @NSManaged public var author: BPerson?
    @NSManaged public var files: NSSet?
    @NSManaged public var followups: NSSet?
    @NSManaged public var references: NSSet?
    @NSManaged public var thread: BThread?

}

// MARK: Generated accessors for files
extension BPost {

    @objc(addFilesObject:)
    @NSManaged public func addToFiles(_ value: BAsset)

    @objc(removeFilesObject:)
    @NSManaged public func removeFromFiles(_ value: BAsset)

    @objc(addFiles:)
    @NSManaged public func addToFiles(_ values: NSSet)

    @objc(removeFiles:)
    @NSManaged public func removeFromFiles(_ values: NSSet)

}

// MARK: Generated accessors for followups
extension BPost {

    @objc(addFollowupsObject:)
    @NSManaged public func addToFollowups(_ value: BPost)

    @objc(removeFollowupsObject:)
    @NSManaged public func removeFromFollowups(_ value: BPost)

    @objc(addFollowups:)
    @NSManaged public func addToFollowups(_ values: NSSet)

    @objc(removeFollowups:)
    @NSManaged public func removeFromFollowups(_ values: NSSet)

}

// MARK: Generated accessors for references
extension BPost {

    @objc(addReferencesObject:)
    @NSManaged public func addToReferences(_ value: BPost)

    @objc(removeReferencesObject:)
    @NSManaged public func removeFromReferences(_ value: BPost)

    @objc(addReferences:)
    @NSManaged public func addToReferences(_ values: NSSet)

    @objc(removeReferences:)
    @NSManaged public func removeFromReferences(_ values: NSSet)

}
