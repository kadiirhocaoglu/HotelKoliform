//
//  AddRegistrationTableViewController.swift
//  Hotel Koliform
//
//  Created by Kadir Hocaoğlu on 25.08.2023.
//

import UIKit

class AddRegistrationTableViewController: UITableViewController{

    // MARK: - UI Elements
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!

    @IBOutlet var checkInDateLabel: UILabel!
    @IBOutlet var checkOutDateLabel: UILabel!
    @IBOutlet var checkInDatePicker: UIDatePicker!
    @IBOutlet var checkOutDatePicker: UIDatePicker!
    
    
    // MARK: - Properties
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let midnightToday = Calendar.current.startOfDay(for: Date())
        checkInDatePicker.minimumDate = midnightToday
        
        checkInDatePicker.date = midnightToday
        
    }
    
    // MARK: - Functions
    func updateDateView(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        let oneDay: Double = 24 * 60 * 60
        
        
        var checkOutMinDate = checkInDatePicker.date.addingTimeInterval(oneDay)
        
        checkOutDatePicker.minimumDate = checkOutMinDate
        
        checkInDateLabel.text = dateFormatter.string(from: checkInDatePicker.date)
        checkOutDateLabel.text = dateFormatter.string(from: checkOutDatePicker.date)
    }
    
    // MARK: - Actions
    @IBAction func doneBarButtonTapped(_ button: UIBarButtonItem){
       /* let firstName = nameTextField!
        let lastName = lastNameTextField!
        let email = emailTextField!
       */
    }
    @IBAction func datePickerValueChanged(_ datePicker: UIDatePicker)
    {
        updateDateView()
    }


}
