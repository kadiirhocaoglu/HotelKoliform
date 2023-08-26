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
    
    @IBOutlet var numberOfAdultsLabel: UILabel!
    @IBOutlet var numberOfAdultsStepper: UIStepper!
    @IBOutlet var numberOfChildrenLabel: UILabel!
    @IBOutlet var numberOfChildrenStepper: UIStepper!
    
    // MARK: - Properties
    let checkInDatePickerCellIndexPath = IndexPath(row: 1, section: 1)
    let checkInDateLabelCellIndexPath = IndexPath(row: 0, section: 1)
    let checkOutDatePickerCellIndexPath = IndexPath(row: 3, section: 1)
    let checkOutDateLabelCellIndexPath = IndexPath(row: 2, section: 1)
    
    var ischeckInDatePickerShown: Bool = false{
        didSet{
            checkInDatePicker.isHidden = !ischeckInDatePickerShown       }
    }
    var ischeckOutDatePickerShown: Bool = false{
        didSet{
            checkOutDatePicker.isHidden = !ischeckOutDatePickerShown
        }
    }
    
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
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath{
        case checkInDatePickerCellIndexPath:
            if ischeckInDatePickerShown{
                return 216
            }
            else{
                return 0
            }
        case checkOutDatePickerCellIndexPath:
            if ischeckOutDatePickerShown{
                return 216
            }
            else{
                return 0
            }
        default:
            return 44
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath{
        case checkInDateLabelCellIndexPath:
            if ischeckInDatePickerShown{
                ischeckInDatePickerShown = false
            }else if ischeckInDatePickerShown{
                ischeckOutDatePickerShown = false
                ischeckInDatePickerShown = true
            }else{
                ischeckInDatePickerShown = true
            }
            tableView.beginUpdates()
            tableView.endUpdates()
            
        case checkOutDateLabelCellIndexPath:
            if ischeckOutDatePickerShown{
                 ischeckOutDatePickerShown = false
            }else if ischeckInDatePickerShown{
                ischeckOutDatePickerShown = true
                ischeckInDatePickerShown = false
            }else{
                ischeckOutDatePickerShown = true
            }
            tableView.beginUpdates()
            tableView.endUpdates()
        default:
            break
        }
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
    @IBAction func updateStepperLabelView(_ stepper: UIStepper){
        var numOfAdults: Int!
        var numOfChildren: Int!
        if stepper == numberOfAdultsStepper{
            numberOfAdultsLabel.text = "\(Int(stepper.value))"
            numOfAdults = Int(stepper.value)
            print("\(numOfAdults)")
        }else if stepper == numberOfChildrenStepper{
            numberOfChildrenLabel.text = "\(Int(stepper.value))"
            numOfChildren = Int(stepper.value)
            print("\(numOfChildren)")
        }
    }


}
