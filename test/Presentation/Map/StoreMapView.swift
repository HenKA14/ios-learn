import SwiftUI
import MapKit

struct StoreMapView: View {
    @State private var locationManager = LocationManager()
    @State private var position: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: -12.1097, longitude: -77.0353),
            span: MKCoordinateSpan(latitudeDelta: 0.08, longitudeDelta: 0.08)
        )
    )

    var body: some View {
        NavigationStack {
            Map(position: $position) {
                ForEach(StoreLocation.mockStores) { store in
                    Annotation(store.name, coordinate: store.coordinate) {
                        VStack(spacing: 2) {
                            Image(systemName: "storefront.fill")
                                .foregroundStyle(.white)
                                .padding(8)
                                .background(.blue, in: Circle())
                            Text(store.name)
                                .font(.caption2)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 2)
                                .background(.white.opacity(0.9))
                                .clipShape(Capsule())
                        }
                    }
                }
                UserAnnotation()
            }
            .navigationTitle("Tiendas cercanas")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        centerOnUser()
                    } label: {
                        Image(systemName: "location.fill")
                    }
                    .help("Centrar en mi ubicación")
                }
            }
            .onAppear {
                locationManager.requestPermission()
            }
            .onChange(of: locationManager.userLocation) { _, location in
                guard let location else { return }
                withAnimation {
                    position = .region(
                        MKCoordinateRegion(
                            center: location.coordinate,
                            span: MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04)
                        )
                    )
                }
            }
        }
    }

    private func centerOnUser() {
        guard let location = locationManager.userLocation else {
            locationManager.requestPermission()
            return
        }
        withAnimation {
            position = .region(
                MKCoordinateRegion(
                    center: location.coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04)
                )
            )
        }
    }
}
