
import Foundation
import CoreLocation


protocol LocationControllerDelegate {
    func locationController(userInfo: NSDictionary, locationCoordenates: CLLocation)
}

class LocationController: NSObject, CLLocationManagerDelegate {
   
    var locationManager:CLLocationManager = CLLocationManager()
    var delegate: LocationControllerDelegate?
    
    override init() {
        super.init()
        
        locationManager.delegate = self;
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
    }
    
    func stopLocationManager() {
        locationManager.stopUpdatingLocation();
    }
    
    func startLocationManager() {
        locationManager.startUpdatingLocation();
        locationManager.requestWhenInUseAuthorization();
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
        case .AuthorizedWhenInUse, .AuthorizedAlways:
            locationManager.startUpdatingLocation()
            break
        case .NotDetermined:
            locationManager.requestAlwaysAuthorization()
            break
        case .Restricted, .Denied:
            break
        }
    }

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            reverseGeoLocation(location)
        }
    
    }
    
    private func reverseGeoLocation(location: CLLocation!){
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, e) -> Void in
            if let error = e {
                print("Error:  \(error.localizedDescription)")
            } else {
                let placemark = placemarks!.last
                
                if let _ = placemark!.locality as NSString!
                {
                    let userInfo = NSMutableDictionary()
                    userInfo.setValue(placemark?.postalCode, forKeyPath: "PostalCode")
                    
                    print("Location:  \(userInfo)")
                    if let delegate = self.delegate {
                        self.locationManager.stopUpdatingLocation()
                        delegate.locationController(userInfo as NSDictionary, locationCoordenates: location)
                    }
                }else{
                    if let delegate = self.delegate {
                        self.locationManager.stopUpdatingLocation()
                        delegate.locationController(NSDictionary(), locationCoordenates: location)
                    }
                }
            }
        })
    }
}
