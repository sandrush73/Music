//
//  Items+CoreDataClass.swift
//  DreamLister
//
//  Created by Rusheel  Sandri on 9/6/18.
//  Copyright © 2018 Rusheel  Sandri. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Items)
public class Items: NSManagedObject {
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.created = NSDate()

    }

}
