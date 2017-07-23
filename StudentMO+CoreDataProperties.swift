//
//  StudentMO+CoreDataProperties.swift
//  aaa
//
//  Created by Developer on 22/07/17.
//  Copyright © 2017 Developer. All rights reserved.
//

import Foundation
import CoreData


extension StudentMO {

    @nonobjc public class func fetch() -> NSFetchRequest<StudentMO> {
        return NSFetchRequest<StudentMO>(entityName: "Student");
    }

    @NSManaged public var name: String?
    @NSManaged public var department: String?
    @NSManaged public var newRelationship: DepartmentMO?

}
