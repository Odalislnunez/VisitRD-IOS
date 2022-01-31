//
//  PlaceDownloader.swift
//  places
//
//  Created by user209612 on 1/30/22.
//

import Foundation
import CoreData

struct PlaceDownloader {
    
    static let placeURL = URL(string:"https://visitrd-ios.000webhostapp.com/SPlaces.json")!
    static var downloading = false
    
    func download() {
        guard !PlaceDownloader.downloading else { return }
        
        let session = URLSession.shared
        Task {
            if let (data, _) = try? await session.data(from: PlaceDownloader.placeURL, delegate: nil) {
                
                let decoder = JSONDecoder()
                decoder.userInfo[Place.contextKey] = PersistenceController.shared.container.viewContext
                
                _ = try? decoder.decode([Place].self, from: data)
                
                try? PersistenceController.shared.container.viewContext.save()
                
            }
        }
    }
}
