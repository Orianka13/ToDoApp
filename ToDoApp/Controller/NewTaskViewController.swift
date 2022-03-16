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

    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var locationTF: UITextField!
    @IBOutlet var dateTF: UITextField!
    @IBOutlet var addressTF: UITextField!
    @IBOutlet var descriptionTF: UITextField!
    
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
        guard let addressString = self.addressTF.text else { return }
        let descriptionString = self.descriptionTF.text
        
        self.geocoder.geocodeAddressString(addressString) { [weak self] placemarks, error in
            let placemark = placemarks?.first
            let coordinate = placemark?.location?.coordinate
            let task = Task(title: titleString, description: descriptionString, date: date, location: Location(name: locationString, coordinate: coordinate))
            
            self?.taskManager.add(task: task)
            print(task)
            
            DispatchQueue.main.async {
                self?.dismiss(animated: true, completion: nil)
            }
        }
        
    }
}
