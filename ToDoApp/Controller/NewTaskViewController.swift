//
//  NewTaskViewController.swift
//  ToDoApp
//
//  Created by Олеся Егорова on 10.03.2022.
//

import UIKit
import CoreLocation

class NewTaskViewController: UIViewController {
    
    var taskManager: TaskManager!
    var geocoder = CLGeocoder()

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var locationTF: UITextField!
    @IBOutlet weak var dateTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var descriptionTF: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    private var dateFormatter: DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yy"
        return df
    }
    
    @IBAction func save() {
        guard let titleString = self.titleTextField.text else { return }
        guard let locationString = self.locationTF.text else { return }
        
        guard let dateString = self.dateTF.text else { return }
        let date = dateFormatter.date(from: dateString)
        
        
        let addressString = self.addressTF.text
        let descriptionString = self.descriptionTF.text
        
        guard let addressString = addressString else { return }
        self.geocoder.geocodeAddressString(addressString) { [weak self] placemarks, error in
            let placemark = placemarks?.first
            let coordinate = placemark?.location?.coordinate
            
            let task = Task(title: titleString, description: descriptionString, date: date, location: Location(name: locationString, coordinate: coordinate))
            
            self?.taskManager.add(task: task)
        }
    }
}
