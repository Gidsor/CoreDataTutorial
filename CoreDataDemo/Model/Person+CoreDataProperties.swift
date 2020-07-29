//
//  Person+CoreDataProperties.swift
//  CoreDataDemo
//
//  Created by Vadim Denisov on 30.07.2020.
//  Copyright © 2020 Vadim Denisov. All rights reserved.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var age: Int64
    @NSManaged public var gender: String?
    @NSManaged public var name: String?

}
