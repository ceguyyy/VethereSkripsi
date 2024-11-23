//
//  VetAnnotation.swift
//  VetHereiOS
//
//  Created by Christian Gunawan on 30/10/24.
//

import Foundation
import CoreLocation

class VetAnnotationModel: Identifiable {
    var id = UUID()
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees

    init(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        self.latitude = latitude
        self.longitude = longitude
    }

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
