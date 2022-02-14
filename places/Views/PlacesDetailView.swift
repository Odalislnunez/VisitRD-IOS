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
    @State var items: [Any] = []
    @State var sheet = false
    
    var body: some View{
        let url = URL(string: place.images ?? "")
        let data = try? Data(contentsOf: url!)
        
        VStack(alignment: .center) {
            Text(place.name ?? "")
                .font(.largeTitle)
                .bold()
            
            Text(place.location ?? "")
                .font(.subheadline)
            
            AsyncImage(url: url) {
                image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }.frame(width: 200, height: 200, alignment: .center)
            
            Text("Description:")
                .bold()
                .frame(
                      minWidth: 0,
                      maxWidth: .infinity,
                      minHeight: 0,
                      maxHeight: 20,
                      alignment: .leading
                    )
            
            Text(place.descrip ?? "")
                .font(Font.system(size: 13))
                .multilineTextAlignment(.leading)
            
            Text("Reviews and Google Search:")
                .bold()
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: 20,
                    alignment: .leading
                  )
            
            VStack(alignment: .center)
                {
                    WebView(request: URLRequest(url: URL(string: place.comments ?? "")!)).aspectRatio(contentMode: .fit)
                }
        }.frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .center
          ).toolbar {
            ToolbarItem {
                HStack {
                    NavigationLink(destination: MapsView(place: place),
                                   isActive: $isShowingMap,
                                   label: {EmptyView()} )
                    
                    HStack {
                        VStack{
                            Button(action: {
                                
                                items.removeAll()
                                items.append(UIImage(data: data!)!)
                                sheet.toggle()
                                
                            }) {
                                Image (systemName: "square.and.arrow.up")
                            }
                        }
                        .sheet(isPresented: $sheet, content: {
                            ShareSheet(items: items)
                        })
                        
                        Button(action: {
                            isShowingMap = true
                        }) {
                            Image(systemName: "mappin.and.ellipse")
                        }
                    }
                    
                }
            }
        }.padding([.leading, .trailing],24)
    }
}

struct ShareSheet : UIViewControllerRepresentable {
    var items: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        
        let controller = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        
    }
}

struct PlacesDetailView_Previews: PreviewProvider {
    
    static func thePlace() -> Place {
        let place = Place(entity: Place.entity(), insertInto: PersistenceController.preview.container.viewContext)
        place.name = "Monumento"
        place.location = "Santiago"
        place.descrip = "This is my description."
        place.images = "https://lh5.googleusercontent.com/p/AF1QipM6m4VuHejk_PRf2N41zLcyJG_4FxAx6cl2DZ54=w1080-k-no"
        place.comments = "https://www.alltrails.com/es/trail/dominican-republic/azua/sendero-cola-de-pato"
        return place
    }
    
    static var previews: some View {
        PlacesDetailView(place: thePlace())
    }
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
