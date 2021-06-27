//
//  ViewController.swift
//  semana12Maps
//
//  Created by mbtec22 on 5/30/21.
//

import UIKit
import MapKit
import CoreLocation
class ViewController: UIViewController {

    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var mapView: MKMapView!
    var locationManager: CLLocationManager?
    var pintAnnotation: CusstomPointAnnotation?
    var pointAnnotation: MKPointAnnotation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMap()
        addAnnotations(coords: getCoordinates())
        // Do any additional setup after loading the view.
    }
    //controlar mapa
    func setUpMap(){
        //tipos de mapa
        mapView.delegate = self
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.showsUserLocation = true
        mapView.setUserTrackingMode(MKUserTrackingMode.follow, animated: true)
    }
    
    func requestLocation(){
        guard CLLocationManager.locationServicesEnabled()else{return}
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestAlwaysAuthorization()
        locationManager?.startUpdatingLocation()
    }
    

    @IBAction func actionSegmentControl(_ sender: Any) {
        //0,1,2,3
        switch segmentControl.selectedSegmentIndex {
        case  0:
            mapView.mapType = .standard
        case  1:
            mapView.mapType = .satellite
        case  2:
            mapView.mapType = .hybrid
        case  3:
            mapView.mapType = .hybridFlyover
        default:
            break
        }
    }
    
    func getCoordinates() -> [CLLocation] {
        return[
            CLLocation(latitude: -12.0447773, longitude: -76.9544714),
            CLLocation(latitude: -12.0210047, longitude: -12.0464746),
            CLLocation(latitude: -12.0455686, longitude: -76.9564661),
            CLLocation(latitude: -12.0454803, longitude: -76.950959),
            CLLocation(latitude: -12.044040130148867, longitude: -76.95288446137397)
        ]
    }
    
    func addAnnotations(coords:[CLLocation]) {
        for coord in coords{
            let CLLCoordType = CLLocationCoordinate2D(
                latitude: coord.coordinate.latitude ,
                longitude: coord.coordinate.longitude
            );
            let annotation = CusstomPointAnnotation()
            annotation.coordinate = CLLCoordType
            annotation.pintCustomImage = "marker"
            annotation.title = "Ubicacion"
            annotation.subtitle = "Subtitulo"
            
            mapView.addAnnotation(annotation)
            
        }
    }
    
    
}
extension ViewController: CLLocationManagerDelegate{
    
}
extension ViewController: MKMapViewDelegate{
    
}

