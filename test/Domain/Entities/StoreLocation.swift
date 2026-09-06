import CoreLocation

struct StoreLocation: Identifiable {
    let id = UUID()
    let name: String
    let address: String
    let coordinate: CLLocationCoordinate2D
}

extension StoreLocation {
    static let mockStores: [StoreLocation] = [
        StoreLocation(
            name: "Tienda Miraflores",
            address: "Av. Larco 1234, Miraflores",
            coordinate: CLLocationCoordinate2D(latitude: -12.1191, longitude: -77.0291)
        ),
        StoreLocation(
            name: "Tienda San Isidro",
            address: "Av. Javier Prado Este 850",
            coordinate: CLLocationCoordinate2D(latitude: -12.0997, longitude: -77.0353)
        ),
        StoreLocation(
            name: "Tienda Surco",
            address: "Av. Caminos del Inca 456",
            coordinate: CLLocationCoordinate2D(latitude: -12.1444, longitude: -76.9903)
        ),
        StoreLocation(
            name: "Tienda Barranco",
            address: "Jr. Unión 789, Barranco",
            coordinate: CLLocationCoordinate2D(latitude: -12.1456, longitude: -77.0216)
        ),
        StoreLocation(
            name: "Tienda San Borja",
            address: "Av. San Luis 1050, San Borja",
            coordinate: CLLocationCoordinate2D(latitude: -12.1031, longitude: -76.9967)
        )
    ]
}
