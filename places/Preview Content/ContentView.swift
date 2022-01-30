//
//  ContentView.swift
//  places
//

import SwiftUI
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
                        AsyncImage(url: URL(string: place.comment ?? "")) {
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
            
//            List(locations){locations in
//
//                NavigationLink(locations.name + "\n" + locations.location, destination: {
//                    PlaceDetailsView(placeDetails: locations)
//                        })
//
//            AsyncImage(url: URL(string: locations.images[0])){
//                    image in
//                image.resizable()
//                .aspectRatio(contentMode:.fit)
//                .padding(2)
//                } placeholder: {
//                Color.red
//                }
//                .frame(width: 300, height: 200)
//                .mask(RoundedRectangle(cornerRadius: 30))
//                 .padding(2)
//                 .shadow(color:.yellow, radius:5, x: 0.50, y: 0.50)
//
//
//                    }.navigationTitle("Visit RD")
//
//                }.onAppear(perform: readFile)
                
       
    }

}

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
        
//        VStack{
//            WebView(request: URLRequest(url: URL(string: "https://www.google.com/maps/place/\(placeDetails.place)")!)).aspectRatio(contentMode:.fit)
//                .frame(width: 450, height: 650)
//                .mask(RoundedRectangle(cornerRadius: 30))
//                 .padding(2)
//                 .shadow(color:.yellow, radius:5, x: 0.50, y: 0.50)
//
//        }
//
        
        VStack(alignment:.trailing)
        {
            WebView(request: URLRequest(url: URL(string: place.comments)!)).aspectRatio(contentMode:.fit)
        }

//        VStack(alignment:.trailing)
//        {
//            WebView(request: URLRequest(url: URL(    string:"https://www.bing.com/images/search?q=\(placeDetails.place)")!)).aspectRatio(contentMode:.fit)
//        }
//
        

        
        
        
    
}
struct WebView : UIViewRepresentable {
    let request: URLRequest
    func makeUIView(context: Context) -> WKWebView  {
        return WKWebView()
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }

}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
//        ContentView().previewLayout(
//                    .fixed(width: 50, height: 50)
//                )
        
        ContentView()
        
    }
    
}
  
}
  

