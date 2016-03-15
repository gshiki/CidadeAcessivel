//
//  ViewController.swift
//  CidadeAcessivel
//  **************************************************
//   Controller responsavel pela view inicial do aplicativo
//  **************************************************
//  Created by Student on 3/11/16.
//  Copyright © 2016 Student. All rights reserved.
//

/*
Teste pelo xcode
*/

import UIKit
import MapKit
import CoreLocation



class ViewController: UIViewController, CLLocationManagerDelegate {


    // CONSTANTES
    let mapPropertyZoom = 0.02 // quanto menor mais detalhado e restrito
    let mapPropertyRegionRadius: CLLocationDistance = 1000
    // ANDRE - Criando o locationManager para buscar a localização do usuário
    let locationManager = CLLocationManager()
    
    // VARIAVEIS
    var mapFirstTimeLocating = true;
    
    // OUTLETS
    @IBOutlet weak var mapviewMain: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ANDRE - Atribuindo o delegate
        self.locationManager.delegate = self
        // ANDRE - Precisão da localização
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // ANDRE - Requisitando a permissão do usuário
        self.locationManager.requestWhenInUseAuthorization()
        
        self.locationManager.startUpdatingLocation()
        
        // INICIALIZA O MAPA
        self.mapviewMain.delegate = self
        self.mapviewMain.showsUserLocation = true
        
        initializeMapMarkers()
    }

    /*
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    */
    
    
    /*  ************************************************************
        * Inicializa os marcadores de opnioes do mapa principal
        ************************************************************
    */
    func initializeMapMarkers() {
        let opnionMarker = OpnionMarker(
            title: "Algum Título",
            locationName: "Alguma Localização",
            coordinate: CLLocationCoordinate2D(latitude: -3.769182, longitude: -38.483889)
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
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if (mapFirstTimeLocating) {
            let zoom = mapPropertyZoom
            let location = locations.last
            let center = CLLocationCoordinate2D(
                latitude: location!.coordinate.latitude,
                longitude: location!.coordinate.longitude
            )
            let region = MKCoordinateRegion(
                center: center,
                span: MKCoordinateSpan(latitudeDelta: zoom, longitudeDelta: zoom)
            )
            
            self.mapviewMain.accessibilityActivate()
            
            self.mapviewMain.setRegion(region, animated: true)
            
            mapFirstTimeLocating = false;
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Erro: " + error.localizedDescription)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}

