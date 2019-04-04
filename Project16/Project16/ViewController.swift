//
//  ViewController.swift
//  Project16
//
//  Created by Pawan Kumar on 03/04/19.
//  Copyright © 2019 PawanShivHari inc. All rights reserved.
//

import MapKit
import UIKit
import SafariServices

class ViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()


        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.50722, longitude: -0.1275), info: "Home to the 2012 Summer olymbics",url:"https://en.wikipedia.org/wiki/London" )
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.",url:"https://en.wikipedia.org/wiki/Oslo")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light.",url:"https://en.wikipedia.org/wiki/Paris")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.",url:"https://en.wikipedia.org/wiki/Rome")
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.",url:"https://en.wikipedia.org/wiki/Washington_(state)")
        let india = Capital(title: "India", coordinate: CLLocationCoordinate2D(latitude: 20.5937, longitude: 78.9629), info: "A Cultural Nation",url:"https://en.wikipedia.org/wiki/India")

        mapView.addAnnotations([london, oslo, paris, rome, washington,india])
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard  annotation is Capital else {
            return nil
        }
        
        let identifier = "Capital"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.pinTintColor =  UIColor.black
            annotationView?.canShowCallout = true
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return  }
        
        let placeName = capital.title
        let placeInfo = capital.info
        
        if let url = URL(string: capital.url) {
            let vc = SFSafariViewController(url: url, entersReaderIfAvailable: true)
            vc.delegate = self
            
            present(vc, animated: true)
        }
//        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
//        ac.addAction(UIAlertAction(title: "Ok", style: .default))
//        present(ac, animated: true, completion: nil)
    }
    
    @IBAction func mapTypeButtonTapped(_ sender: Any) {
        showSimpleActionSheet()
    }

    
    

        func showSimpleActionSheet() {
            var mapType: MKMapType = .standard
            let alert = UIAlertController(title: "Map View Type", message: "Please Select an Option", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "standard", style: .default, handler: { (_) in
                print("")
                mapType = .standard
                self.mapView.mapType = mapType
            }))
            
            alert.addAction(UIAlertAction(title: "Satellite", style: .default, handler: { (_) in
                 mapType = .satellite
                self.mapView.mapType = mapType
            }))
            
            alert.addAction(UIAlertAction(title: "hybrid", style: .destructive, handler: { (_) in
                 mapType = .hybrid
                self.mapView.mapType = mapType
            }))
            
            alert.addAction(UIAlertAction(title: "satelliteFlyover", style: .default, handler: { (_) in
                mapType = .satelliteFlyover
                self.mapView.mapType = mapType
            }))
            
            alert.addAction(UIAlertAction(title: "hybridFlyover", style: .default, handler: { (_) in
                mapType = .hybridFlyover
                self.mapView.mapType = mapType
            }))
            
            
            
            alert.addAction(UIAlertAction(title: "mutedStandard", style: .default, handler: { (_) in
               mapType = .mutedStandard
                self.mapView.mapType = mapType
            }))
            
            
            
            self.present(alert, animated: true, completion: { [weak self] in
                print("completion block")
                
            })
        }
}


extension ViewController : SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true)
    }
}
