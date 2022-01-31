//
//  Place+CoreDataProperties.swift
//  places
//
//  Created by user209612 on 1/30/22.
//

import Foundation
import CoreData


extension Place {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Place> {
        return NSFetchRequest<Place>(entityName: "Place")
    }

    @NSManaged public var id: Int
    @NSManaged public var name: String?
    @NSManaged public var location: String?
    @NSManaged public var descrip: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var rating: Double
    @NSManaged public var images: String?
    @NSManaged public var comments: String?
    
}

extension Place : Identifiable {

}
