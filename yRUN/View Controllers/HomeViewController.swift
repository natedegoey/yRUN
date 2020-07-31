//
//  HomeViewController.swift
//  yRUN
//
//  Created by Nathan DeGoey on 2020-07-26.
//  Copyright © 2020 Nathan DeGoey. All rights reserved.
//

import UIKit
import MapKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    // White house long and lat
    // 38.8977° N, 77.0365° W
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // add an example annotation to the map
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 38.8977, longitude: -77.0365)
        annotation.title = "Ronald McDonald House Charities"
        annotation.subtitle = "Based in Washington D.C., USA"
        mapView.addAnnotation(annotation)
        
        // Define the region that the map first loads on by getting the the annotation defined above
        //let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        //mapView.setRegion(region, animated: true)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    

}

