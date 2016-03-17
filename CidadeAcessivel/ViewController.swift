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
import CoreData

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    // CONSTANTES
    let mapPropertyZoom = 0.02 // quanto menor mais detalhado e restrito
    let mapPropertyAnimationDuration = 3.0 // em segundos
    let mapPropertyAnimationDelay = 0.0
    let mapPropertyAnimationSpring:CGFloat = 1.2 // velocidade de mudanca de frames no final
    let mapPropertyAnimationInitialSpring:CGFloat = 1.2 // velocidade de mudanca de frames no inicio
    let pinPropertyWidth:CGFloat = 28
    let pinPropertyHeight:CGFloat = 28
    let gesturePressTime = 0.5
    
    
    let mapPropertyRegionRadius: CLLocationDistance = 1000
    // ANDRE - Criando o locationManager para buscar a localização do usuário
    let locationManager = CLLocationManager()
    
    // VARIAVEIS
    var mapFirstTimeLocating = true
    var coordenadasOpniao: CLLocationCoordinate2D?
    
    // OUTLETS
    @IBOutlet weak var mapviewMain: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let longPressGR = UILongPressGestureRecognizer(target: self, action: "registerOpnion:")
        longPressGR.minimumPressDuration = gesturePressTime
        self.mapviewMain.addGestureRecognizer(longPressGR)
        
        // ANDRE - Atribuindo o delegate
        self.locationManager.delegate = self
        // ANDRE - Precisão da localização
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // ANDRE - Requisitando a permissão do usuário
        self.locationManager.requestWhenInUseAuthorization()
        
        self.locationManager.startUpdatingLocation()
        
        // INICIALIZA O MAPA
        self.mapviewMain.delegate = self
        //self.mapviewMain.showsUserLocation = true
        
        initializeMapMarkers()
    }
    
    override func viewWillAppear(animated: Bool) {
        initializeMapMarkers()
    }
    
    /*
    override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    }
    */
    
    
    /*
    ************************************************************
    * ANDRE - Adiciona um local apos um Long Press
    ************************************************************
    */
    func registerOpnion(GR:UIGestureRecognizer) {
        if (GR.state == UIGestureRecognizerState.Began) {
            // local do ponto que foi tocado
            let touchPoint = GR.locationInView(self.mapviewMain)
            // convertendo o ponto em coordenadas
            self.coordenadasOpniao = self.mapviewMain.convertPoint(touchPoint, toCoordinateFromView: self.mapviewMain)
            
            performSegueWithIdentifier("registrarLocal", sender: nil)
        }
        
    }
    
    /*
    ************************************************************
    * Inicializa os marcadores de opnioes do mapa principal
    ************************************************************
    */
    func initializeMapMarkers() {
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext
        
        let request = NSFetchRequest(entityName: "Locais")
        
        request.returnsObjectsAsFaults = false
        
        var resultsLocations: NSArray = []
        
        do {
            resultsLocations = try context.executeFetchRequest(request)
        } catch {
            
        }
        
        if resultsLocations.count > 0 {
            for location: AnyObject in resultsLocations {
                var localName:String = location.primitiveValueForKey("local") as! String
                var localDescription:String = location.primitiveValueForKey("descricao") as! String
                var latitude:CLLocationDegrees = location.valueForKey("latitude") as! CLLocationDegrees
                var longitude:CLLocationDegrees = location.primitiveValueForKey("longitude") as! CLLocationDegrees
                
                var localMarker = LocalMarker(
                    title: localName,
                    locationName: localDescription,
                    coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                )
                mapviewMain.addAnnotation(localMarker)
            }
        } else {
            print("Nenhum resultado encontrado. Verificar erro")
        }
        
        /*
        let opnionMarker = OpnionMarker(
            title: "Algum Título",
            locationName: "Alguma Localização",
            coordinate: CLLocationCoordinate2D(latitude: -3.769182, longitude: -38.483889)
        )
        mapviewMain.addAnnotation(opnionMarker)
        */
    }
    
    /*  
    ************************************************************
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
                longitude: location!.coordinate.longitude)
            
            let region = MKCoordinateRegion(
                center: center,
                span: MKCoordinateSpan(latitudeDelta: zoom, longitudeDelta: zoom))
            
            self.mapviewMain.accessibilityActivate()
            
            MKMapView.animateWithDuration(mapPropertyAnimationDuration,
                delay: mapPropertyAnimationDelay,
                usingSpringWithDamping: mapPropertyAnimationSpring,
                initialSpringVelocity: mapPropertyAnimationInitialSpring,
                options: UIViewAnimationOptions.CurveEaseIn,
                animations: {
                    self.mapviewMain.setRegion(region, animated: true)
                }, completion: nil)
            
            mapFirstTimeLocating = false;
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        //print("Erro: " + error.localizedDescription)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let backButtonItem = UIBarButtonItem()
        
        backButtonItem.title = "Voltar"
        
        navigationItem.backBarButtonItem = backButtonItem
        
        if segue.identifier == "registrarLocal" {
            
            if let localRegisterController = segue.destinationViewController as? LocalRegisterController {
                localRegisterController.coordenadasOpniao = self.coordenadasOpniao
            }
        }
    }
    
}