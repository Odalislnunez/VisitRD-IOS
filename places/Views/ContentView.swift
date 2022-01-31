//
//  ContentView.swift
//  places
//

import SwiftUI
import CoreData
import MapKit
import WebKit

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
        
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath:\Place.name, ascending: true)], predicate: nil, animation: .default)
    
    private var places: FetchedResults<Place>
   
    var body: some View {
        
        NavigationView{
            
            List {
                ForEach(places) { place in NavigationLink(destination: PlacesDetailView(place: place)) {
                    HStack {
                        AsyncImage(url: URL(string: place.images ?? "")) {
                            image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }.frame(width: 40, height: 40, alignment: .leading)
                        
                        Text(place.name ?? "")
                        
                        Text(place.location ?? "")
                        }
                    }
                }
            }.navigationTitle("Visit RD")
            
        }.onAppear {
            if places.count == 0 {
                PlaceDownloader().download()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}



  

