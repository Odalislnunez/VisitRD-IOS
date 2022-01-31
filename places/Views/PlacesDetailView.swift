//
//  PlacesDetailView.swift
//  places
//

import SwiftUI
import CoreData
import MapKit
import WebKit

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
//    VStack(alignment:.trailing)
//        {
//            WebView(request: URLRequest(url: URL(string: place.comments)!)).aspectRatio(contentMode:.fit)
//        }
//
//}

struct WebView : UIViewRepresentable {
    let request: URLRequest
    func makeUIView(context: Context) -> WKWebView  {
        return WKWebView()
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }

}
