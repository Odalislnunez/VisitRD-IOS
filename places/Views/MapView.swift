//
//  MapView.swift
//  places
//

import MapKit
import SwiftUI
import UIKit

struct MapsView: View {
    @StateObject var place: Place
    @State private var directions: [String] = []
    @State private var showDirections = false
    
  var body: some View {
    VStack {
        MapView(plac: place, directions: $directions)

      Button(action: {
        self.showDirections.toggle()
      }, label: {
        Text("Show directions")
      })
      .disabled(directions.isEmpty)
      .padding()
    }.sheet(isPresented: $showDirections, content: {
      VStack(spacing: 0) {
        Text("Directions")
          .font(.largeTitle)
          .bold()
          .padding()

        Divider().background(Color(UIColor.systemBlue))

        List(0..<self.directions.count, id: \.self) { i in
          Text(self.directions[i]).padding()
        }
      }
    })
  }
}

struct MapView: UIViewRepresentable {
    typealias UIViewType = MKMapView

    @StateObject var plac: Place
    @StateObject var locationManager = LocationManager()
    @Binding var directions: [String]

  func makeCoordinator() -> MapViewCoordinator {
    return MapViewCoordinator()
  }

  func makeUIView(context: Context) -> MKMapView {
    let mapView = MKMapView()
    mapView.delegate = context.coordinator

    let region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: plac.latitude, longitude: plac.longitude),
      span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    mapView.setRegion(region, animated: true)

    // Current Location
//      let p1 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: locationManager.lastLocation?.coordinate.latitude ?? 0, longitude: locationManager.lastLocation?.coordinate.longitude ?? 0))
      
      let p1 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 19.39862, longitude: -70.74283))

    // Place Location
      let p2 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: plac.latitude, longitude: plac.longitude))

    let request = MKDirections.Request()
      request.source = MKMapItem(placemark: p1)
      request.destination = MKMapItem(placemark: p2)
      request.transportType = .automobile

    let directions = MKDirections(request: request)
    directions.calculate { response, error in
      guard let route = response?.routes.first else { return }
        mapView.addAnnotations([p1, p2])
      mapView.addOverlay(route.polyline)
      mapView.setVisibleMapRect(
        route.polyline.boundingMapRect,
        edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20),
        animated: true)
      self.directions = route.steps.map { $0.instructions }.filter { !$0.isEmpty }
    }
    return mapView
  }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
    }
    
  class MapViewCoordinator: NSObject, MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
      let renderer = MKPolylineRenderer(overlay: overlay)
      renderer.strokeColor = .systemBlue
      renderer.lineWidth = 5
      return renderer
    }
  }
}
