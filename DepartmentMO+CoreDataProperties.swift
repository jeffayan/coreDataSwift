//
//  DepartmentMO+CoreDataProperties.swift
//  aaa
//
//  Created by Developer on 22/07/17.
//  Copyright © 2017 Developer. All rights reserved.
//

import Foundation
import CoreData


extension DepartmentMO {

    @nonobjc public class func fetch() -> NSFetchRequest<DepartmentMO> {
        return NSFetchRequest<DepartmentMO>(entityName: "Department");
    }

    @NSManaged public var name: String?
    @NSManaged public var newRelationship: StudentMO?

}
