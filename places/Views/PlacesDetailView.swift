//
//  PlacesDetailView.swift
//  places
//

import SwiftUI
import CoreData

struct PlacesDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @StateObject var place: Place
    
    @State var isShowingMap = false

    var body: some View {
        VStack {
            AsyncImage(url: place.imageURL) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }.frame(width: 150, height: 150, alignment: .center)
            
            Text(place.name ?? "")
        }.toolbar {
            ToolbarItem {
                HStack {
                    NavigationLink(destination: MapView(place: place),
                                   isActive: $isShowingMap,
                                   label: {EmptyView()} )
                    
                    Button("Map") {
                        isShowingMap = true
                    }
                }
            }
        }
    }
}

//struct PlacesDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlacesDetailView()
//    }
//}
//
//struct PlaceDetailsView: View {
//
//    var placeDetails:Location
//    var body: some View{
//        HStack{
//
//            VStack(alignment:.leading) {
//                Text(placeDetails.location)
//                .font(.largeTitle)
//                //.bold()
//                //Spacer()
//                .padding(5)
//            Text(placeDetails.description)
//            Spacer()
//            .font(.caption2)
//            //.padding()
//
//        }.padding([.leading, .trailing],24)
//                .navigationTitle(placeDetails.name)
//            Spacer()
//            //.padding(10)
//
//}
