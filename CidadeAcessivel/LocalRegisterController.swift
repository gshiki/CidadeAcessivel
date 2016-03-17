//
//  OpnionRegisterController.swift
//  CidadeAcessivel
//
//  Created by André Maciel on 3/16/16.
//  Copyright © 2016 Student. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class LocalRegisterController: UITableViewController {
    
    let arrayFieldsForm: [String] = ["Nome do Local", "Descrição", "Botão"]
    
    var coordenadasOpniao: CLLocationCoordinate2D?

    @IBOutlet var tableViewLocation: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //print(self.coordenadasOpniao)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayFieldsForm.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("localFormCell", forIndexPath: indexPath) as! LocalRegisterCell
        
        // PREENCHENDO AS LABELS, APENAS SE NAO FOR A CELULA DO BOTAO
        if indexPath.row < 2 {
            cell.labelField.text = arrayFieldsForm[indexPath.row]
        }
        // MODIFICA PARA APARECER O TEXTVIEW AO INVES DO TEXTFIELD
        if indexPath.row == 1 {
            cell.fieldName.hidden = true
            cell.textViewDescription.hidden = false
            cell.buttonRegisterLocation.hidden = true
        }
        // MODIFICA PARA APARECER O BOTAO
        if indexPath.row == 2 {
            cell.viewSeparator.hidden = true
            cell.labelField.hidden = true
            cell.fieldName.hidden = true
            cell.textViewDescription.hidden = true
            cell.buttonRegisterLocation.hidden = false
            
        }
        
        // ESTILO
        cell.layer.borderColor = UIColor.grayColor().CGColor
        cell.layer.borderWidth = 0.5

        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.row == 1 {
            return 200.0
        }
        return tableViewLocation.rowHeight
    }
    
    /*
    **********
    * Para registrar uma nova localizacao pelo usuario
    **********
    */
    @IBAction func actionRegisterLocation(sender: AnyObject) {
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext
        
        let newLocation = NSEntityDescription.insertNewObjectForEntityForName("Locais", inManagedObjectContext: context) as NSManagedObject
        
        let cellLocalName = tableViewLocation.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! LocalRegisterCell
        let cellLocalDescription = tableViewLocation.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 0)) as! LocalRegisterCell
        
        newLocation.setPrimitiveValue(cellLocalName.fieldName.text, forKey: "local")
        newLocation.setPrimitiveValue(cellLocalDescription.textViewDescription.text, forKey: "descricao")
        newLocation.setPrimitiveValue(coordenadasOpniao?.latitude, forKey: "latitude")
        newLocation.setPrimitiveValue(coordenadasOpniao?.longitude, forKey: "longitude")
        
        do {
            try context.save()
        } catch {
            print("erro")
        }
    }
    

}
