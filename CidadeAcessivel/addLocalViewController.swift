//
//  addLocalViewController.swift
//  CidadeAcessivel
//
//  Created by Student on 3/16/16.
//  Copyright © 2016 Student. All rights reserved.
//

import UIKit
import MapKit

class addLocalViewController: UIViewController {
    
    var coordenadasNovoLocal: CLLocationCoordinate2D?

    override func viewDidLoad() {
        super.viewDidLoad()

        print(self.coordenadasNovoLocal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
