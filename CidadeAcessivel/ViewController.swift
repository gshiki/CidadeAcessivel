//
//  ViewController.swift
//  CidadeAcessivel
//  **************************************************
//   Controller responsavel pela view inicial do aplicativo
//  **************************************************
//  Created by Student on 3/11/16.
//  Copyright © 2016 Student. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    // COSNTANTES
    let mapPropertyLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
    let mapPropertyRegionRadius: CLLocationDistance = 1000
    // OUTLETS
    @IBOutlet weak var mapviewMain: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        centerMapOnLocation(mapPropertyLocation)
        
        initializeMapMarkers()
    }

    /*
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    */
    
    /*  ************************************************************
    * Inicializa o mapa e suas propriedades
    ************************************************************
    */
    func initializeMap() {
        mapviewMain.showsUserLocation = true
        mapviewMain.delegate = self
    }
    
    /*  ************************************************************
        * Inicializa os marcadores de opnioes do mapa principal
        ************************************************************
    */
    func initializeMapMarkers() {
        let opnionMarker = OpnionMarker(
            title: "Algum Título",
            locationName: "Alguma Localização",
            coordinate: CLLocationCoordinate2D(latitude: 21.282778, longitude: -157.829444)
        )
        mapviewMain.addAnnotation(opnionMarker)
    }
    
    /*  ************************************************************
        * Centraliza a visao inicial do mapa no ponto passado por parametro
        ************************************************************
    */
    func centerMapOnLocation(location: CLLocation) {
        let centerRegion = MKCoordinateRegionMakeWithDistance(
            location.coordinate,
            mapPropertyRegionRadius * 2.0,
            mapPropertyRegionRadius * 2.0)
        
        mapviewMain.setRegion(centerRegion, animated: true)
    }

}

