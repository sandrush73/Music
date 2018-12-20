//
//  Items+CoreDataProperties.swift
//  DreamLister
//
//  Created by Rusheel  Sandri on 9/6/18.
//  Copyright © 2018 Rusheel  Sandri. All rights reserved.
//
//

import Foundation
import CoreData


extension Items {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Items> {
        return NSFetchRequest<Items>(entityName: "Items")
    }

    @NSManaged public var created: NSDate?
    @NSManaged public var details: String?
    @NSManaged public var title: String?
    @NSManaged public var price: Double
    @NSManaged public var toImage: Images?
    @NSManaged public var toItemType: ItemType?
    @NSManaged public var toStore: Store?

}
