//
//  NewTaskViewController.swift
//  ToDoApp
//
//  Created by Олеся Егорова on 10.03.2022.
//

import UIKit

class NewTaskViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var locationTF: UITextField!
    @IBOutlet weak var dateTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var descriptionTF: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
}
