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
    let mapPropertyLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
    let mapPropertyRegionRadius: CLLocationDistance = 1000
    // OUTLETS
    @IBOutlet weak var mapviewMain: MKMapView!
    
    // ANDRE - Criando o locationManager para buscar a localização do usuário
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ANDRE - Atribuindo o delegate
        self.locationManager.delegate = self
        // ANDRE - Precisão da localização
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // ANDRE - Requisitando a permissão do usuário
        self.locationManager.requestWhenInUseAuthorization()
        
        self.locationManager.startUpdatingLocation()
        self.mapviewMain.showsUserLocation = true
        
        
        
        //centerMapOnLocation(mapPropertyLocation)
        
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
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        
        let zoom = 0.01 // quanto menor mais detalhado e restrito
        
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: zoom, longitudeDelta: zoom))
        
        self.mapviewMain.setRegion(region, animated: true)
        
        
        //Usar esse comando somente para parar atualizar a atualização automatica do mapa
        //self.locationManager.stopUpdatingLocation()
        
    
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Erro: " + error.localizedDescription)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}

