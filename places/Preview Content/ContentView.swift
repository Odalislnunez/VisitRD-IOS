//
//  ContentView.swift
//  places
//
//  Created by MercWareTecnology on 21/12/21.
//

import SwiftUI
import MapKit
import WebKit
struct ContentView: View {
   
    //creando lista de valores
    @State private var locations: [Location] = []
   // @State private var placeDetails: [Location] = []
   
    var body: some View {
            
        NavigationView{
              
            List(locations){locations in
    
                NavigationLink(locations.name, destination: {
                    PlaceDetailsView(placeDetails: locations)
                        })
                
            AsyncImage(url: URL(string: locations.images[0])){
                    image in
                image.resizable()
                .aspectRatio(contentMode:.fit)
                .padding(2)
                } placeholder: {
                Color.red
                }
                .frame(width: 300, height: 200)
                .mask(RoundedRectangle(cornerRadius: 30))
                 .padding(2)
                 .shadow(color:.yellow, radius:5, x: 0.50, y: 0.50)
                   

                    }.navigationTitle("Visit RD")
                    
                }.onAppear(perform: readFile)
                
       
    }
    
    private func readFile() {
        if let url = URL(string: "https://visitrd-ios.000webhostapp.com/Places.json"),
            let  data = try? Data(contentsOf: url){
            let  decoder = JSONDecoder()
            if let jsonData = try? decoder.decode(JSONData.self, from: data){
                self.locations = jsonData.locations
               
            }
            
        }
    }
    

}


struct JSONData: Decodable {
    let locations:[Location]
    
}
struct Location: Decodable,Identifiable {
    let id: Int
    let name: String
    let location: String
    let description: String
    let latitude: Double
    let longitude: Double
    let rating: Double
    var images: [String]
    let comments: String
    
//    let id: Int
//    let place: String
//    let desc: String
//    let latitude: Double
//    let longitude: Double
//    var images: String
}

struct PlaceDetailsView: View{
    var placeDetails:Location
    var body: some View{
        HStack{
           
            VStack(alignment:.leading) {
                Text(placeDetails.name)
                .font(.largeTitle)
                //.bold()
                //Spacer()
                .padding(5)
            Text(placeDetails.location)
            Spacer()
            .font(.caption2)
            //.padding()
                
        }.padding([.leading, .trailing],24)
        .navigationTitle("Details")
            Spacer()
            //.padding(10)
        
}
        
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
            WebView(request: URLRequest(url: URL(string: "https://www.visitarepublicadominicana.org/que-ver-en-\(placeDetails.name)")!)).aspectRatio(contentMode:.fit)
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
  

