//
//  Images+CoreDataProperties.swift
//  DreamLister
//
//  Created by Rusheel  Sandri on 9/6/18.
//  Copyright © 2018 Rusheel  Sandri. All rights reserved.
//
//

import Foundation
import CoreData


extension Images {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Images> {
        return NSFetchRequest<Images>(entityName: "Images")
    }

    @NSManaged public var image: NSObject?
    @NSManaged public var toItem: Items?
    @NSManaged public var toStore: NSSet?

}

// MARK: Generated accessors for toStore
extension Images {

    @objc(addToStoreObject:)
    @NSManaged public func addToToStore(_ value: Store)

    @objc(removeToStoreObject:)
    @NSManaged public func removeFromToStore(_ value: Store)

    @objc(addToStore:)
    @NSManaged public func addToToStore(_ values: NSSet)

    @objc(removeToStore:)
    @NSManaged public func removeFromToStore(_ values: NSSet)

}
