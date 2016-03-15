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
import UIKit
import MapKit

extension ViewController: MKMapViewDelegate {
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseID = "pinGreen"
        let detailButton: UIButton = UIButton(type: UIButtonType.DetailDisclosure)
        
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseID) as? MKPinAnnotationView
        
        if annotation is MKUserLocation {
            return nil
        }
    
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
            pinView!.canShowCallout = true
            pinView!.animatesDrop = true
            pinView!.image = UIImage(named: "green-comment-icon")
            pinView!.rightCalloutAccessoryView = detailButton
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
}
