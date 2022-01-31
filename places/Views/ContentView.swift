//
//  ContentView.swift
//  places
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
        
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath:\Place.location, ascending: true)], predicate: nil, animation: .default)
    
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
                        VStack {
                            Text(place.name ?? "")
                                .font(Font.system(size: 13))
//                                .fixedSize(horizontal: false, vertical: true)
                                .frame(
                                    minWidth: 0,
                                    maxWidth: .infinity,
                                    minHeight: 0,
                                    maxHeight: .infinity,
                                    alignment: .topLeading
                                  )
                            
                            Text(place.location ?? "")
                                .font(Font.system(size: 12))
                                .bold()
                                .frame(
                                    minWidth: 0,
                                    maxWidth: .infinity,
                                    minHeight: 0,
                                    maxHeight: .infinity,
                                    alignment: .topLeading
                                  )
                        }
                        }
                    }
                }
            }.navigationTitle("Visit RD")
            
        }.onAppear {
//            clearAllCoreData()
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



  

