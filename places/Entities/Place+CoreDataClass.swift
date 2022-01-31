//
//  Place+CoreDataClass.swift
//  places
//

import Foundation
import CoreData

@objc(Place)
public class Place: NSManagedObject, Decodable {
    
    static let contextKey = CodingUserInfoKey(rawValue: "context")!

    var imageURL: URL { URL(string: images ?? "")! }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case location = "location"
        case descrip = "descrip"
        case latitude = "latitude"
        case longitude = "longitude"
        case rating = "rating"
        case images = "images"
        case comments = "comments"
    }
    
    public required convenience init(from decoder: Decoder) throws {
        
        guard let context = decoder.userInfo[Place.contextKey] as? NSManagedObjectContext else {
            fatalError("No context in decoder.")
        }
        
        let entity = NSEntityDescription.entity(forEntityName: "Place", in: context)!
        
        self.init(entity: entity, insertInto: context)
        
        // Decode
        let values = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try values.decode(Int.self, forKey: CodingKeys.id)
        self.name = try values.decode(String.self, forKey: CodingKeys.name)
        self.location = try values.decode(String.self, forKey: CodingKeys.location)
        self.descrip = try values.decode(String.self, forKey: CodingKeys.descrip)
        self.latitude = try values.decode(Double.self, forKey: CodingKeys.latitude)
        self.longitude = try values.decode(Double.self, forKey: CodingKeys.longitude)
        self.rating = try values.decode(Double.self, forKey: CodingKeys.rating)
        self.images = try values.decode(String.self, forKey: CodingKeys.images)
        self.comments = try values.decode(String.self, forKey: CodingKeys.comments)
        
    }
}
