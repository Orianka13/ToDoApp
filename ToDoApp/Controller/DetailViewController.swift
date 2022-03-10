//
//  DetailViewController.swift
//  ToDoApp
//
//  Created by Олеся Егорова on 09.03.2022.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var locationLabel: UILabel!
    
    private var dateFormatter: DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yy"
        return df
    }
    
    var task: Task!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.titleLabel.text = self.task.title
        self.descriptionLabel.text = self.task.description
        
        if let date = task.date {
            self.dateLabel.text = self.dateFormatter.string(from: date)
        }
        
        self.locationLabel.text = self.task.location?.name
    }
}
