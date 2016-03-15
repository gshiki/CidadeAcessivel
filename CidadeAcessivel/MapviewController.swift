//
//  MapviewController.swift
//  CidadeAcessivel
//  **************************************************
//   Controller responsavel pelo mapa
//  **************************************************
//  Created by Student on 3/11/16.
//  Copyright © 2016 Student. All rights reserved.
//

import Foundation
import MapKit

extension ViewController: MKMapViewDelegate {
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
            if !(annotation is MKUserLocation) {
                return nil
            }
            
            let reuseID = "pinGreen"
        
            var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseID) as? MKPinAnnotationView
        
            if pinView == nil {
                pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
                pinView!.canShowCallout = true
                pinView!.animatesDrop = true
                pinView!.image = UIImage(named:"green-comment-icon")!
            }
            else {
                pinView!.annotation = annotation
            }
            
            return pinView
    }
}
