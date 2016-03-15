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
        
        let detailButton: UIButton = UIButton(type: UIButtonType.DetailDisclosure)
        
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier("pinGreen")
        
        if annotation is MKUserLocation {
            return nil
        }
    
        if pinView == nil {
            pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: "pinGreen")
            pinView!.canShowCallout = true
            pinView!.image = iconizeImage( UIImage(named: "green-comment-icon")! )
            pinView!.rightCalloutAccessoryView = detailButton
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    func iconizeImage(image: UIImage) -> UIImage {
        UIGraphicsBeginImageContext( CGSizeMake(pinPropertyWidth, pinPropertyHeight) )
        
        image.drawInRect( CGRectMake(0, 0, pinPropertyWidth, pinPropertyHeight) )
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
