//
//  BAsset+CoreDataProperties.swift
//  
//
//  Created by Reid Ellis on 2017-01-20.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension BAsset {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BAsset> {
        return NSFetchRequest<BAsset>(entityName: "BAsset");
    }

    @NSManaged public var assetIdentifier: String?
    @NSManaged public var downloadFilename: String?
    @NSManaged public var isAnimated: Bool
    @NSManaged public var isComplete: Bool
    @NSManaged public var isMissing: Bool
    @NSManaged public var originallFilename: String?
    @NSManaged public var thumbnailAssetIdentifier: String?
    @NSManaged public var url: String?
    @NSManaged public var post: BPost?

}
