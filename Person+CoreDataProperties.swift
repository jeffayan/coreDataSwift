//
//  Person+CoreDataProperties.swift
//  aaa
//
//  Created by CSS on 27/08/18.
//  Copyright © 2018 Developer. All rights reserved.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetch() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var relationshipTeam: Team?

}
