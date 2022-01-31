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
    
    var body: some View{
        HStack{
            VStack(alignment:.leading) {
                Text(place.name ?? "")
                    .font(.largeTitle)
                    .bold()
                    .padding(5)
                    .frame(width:500, height: 10, alignment: .center)
                
                Text(place.location ?? "")
                    .font(.subheadline)
                    .padding(5)
                    .frame(width: 500, height: 40, alignment: .center)
                
                AsyncImage(url: URL(string: place.images ?? "")) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }.frame(width: 500, height: 150, alignment: .center)
                
                Text(place.descrip ?? "")
                    Spacer()
                    .font(.caption2)

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
        }.padding([.leading, .trailing],24)
            Spacer()
        
//        VStack(alignment:.trailing)
//            {
//                WebView(request: URLRequest(url: URL(string: place.comments ?? "")!)).aspectRatio(contentMode:.fit)
//            }
        }
    }
}

//struct PlacesDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlacesDetailView(place: place).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
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
