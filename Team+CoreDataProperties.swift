//
//  Team+CoreDataProperties.swift
//  aaa
//
//  Created by CSS on 27/08/18.
//  Copyright © 2018 Developer. All rights reserved.
//
//

import Foundation
import CoreData


extension Team {

    @nonobjc public class func fetch() -> NSFetchRequest<Team> {
        return NSFetchRequest<Team>(entityName: "Team")
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var relationship: NSSet?

}

// MARK: Generated accessors for relationship
extension Team {

    @objc(addRelationshipObject:)
    @NSManaged public func addToRelationship(_ value: Person)

    @objc(removeRelationshipObject:)
    @NSManaged public func removeFromRelationship(_ value: Person)

    @objc(addRelationship:)
    @NSManaged public func addToRelationship(_ values: NSSet)

    @objc(removeRelationship:)
    @NSManaged public func removeFromRelationship(_ values: NSSet)

}
