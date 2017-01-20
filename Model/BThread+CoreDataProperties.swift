//
//  BThread+CoreDataProperties.swift
//  
//
//  Created by Reid Ellis on 2017-01-20.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension BThread {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BThread> {
        return NSFetchRequest<BThread>(entityName: "BThread");
    }

    @NSManaged public var board: BBoard?
    @NSManaged public var posts: NSSet?

}

// MARK: Generated accessors for posts
extension BThread {

    @objc(addPostsObject:)
    @NSManaged public func addToPosts(_ value: BPost)

    @objc(removePostsObject:)
    @NSManaged public func removeFromPosts(_ value: BPost)

    @objc(addPosts:)
    @NSManaged public func addToPosts(_ values: NSSet)

    @objc(removePosts:)
    @NSManaged public func removeFromPosts(_ values: NSSet)

}
