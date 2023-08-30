//
//  AddRegistrationTableViewController.swift
//  Hotel Koliform
//
//  Created by Kadir Hocaoğlu on 25.08.2023.
//

import UIKit

class AddRegistrationTableViewController: UITableViewController, SelectRoomTypeTableViewControllerDelegate{
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
    
    @IBOutlet var wifiSwitcher: UISwitch!
    
    @IBOutlet var selectRoomTypeDetailLabel: UILabel!
    
    // MARK: - Properties
    var roomType: RoomType?
    var registration: Registration?{
        guard let roomType = roomType else {return nil}
        
        let firstname = nameTextField.text!
        let lastname = lastNameTextField.text!
        let emailAddress = emailTextField.text!
        let checkInDate = checkInDatePicker.date
        let checkOutDate = checkInDatePicker.date
        let numberOfAdults = Int(numberOfAdultsStepper.value)
        let numberOfChildren = Int(numberOfChildrenStepper.value)
        let hasWifi: Bool = wifiSwitcher.isOn
        
        return Registration(firstName: firstname, lastName: lastname, emailAddress: emailAddress, checkInDate: checkInDate, checkOutDate: checkOutDate, numberOfAdults: numberOfAdults, numberOfChildren: numberOfChildren, roomType: roomType, wifiService: hasWifi)
    }
    let checkInDatePickerCellIndexPath = IndexPath(row: 1, section: 1)
    let checkInDateLabelCellIndexPath = IndexPath(row: 0, section: 1)
    let checkOutDatePickerCellIndexPath = IndexPath(row: 3, section: 1)
    let checkOutDateLabelCellIndexPath = IndexPath(row: 2, section: 1)
    
    var ischeckInDatePickerShown: Bool = false{
        didSet{
            checkInDatePicker.isHidden = !ischeckInDatePickerShown
        }
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
        updateNumOfGuests()
        updateDateView()
        updateRoomType()
    }
    
    // MARK: - Functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectRoomType" {
            let destination = segue.destination as? SelectRoomTypeTableViewController
            destination?.delegate = self
            destination?.selectedRoom = roomType
        }
    }
    
    func didSelect(roomType: RoomType) {
        self.roomType = roomType
        updateRoomType()
    }
    
    
    func updateDateView(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        let oneDay: Double = 24 * 60 * 60
        let checkOutMinDate = checkInDatePicker.date.addingTimeInterval(oneDay)
        checkOutDatePicker.minimumDate = checkOutMinDate
        checkInDateLabel.text = dateFormatter.string(from: checkInDatePicker.date)
        checkOutDateLabel.text = dateFormatter.string(from: checkOutDatePicker.date)
    }
    
    func updateNumOfGuests(){
        numberOfAdultsLabel.text = "\(Int(numberOfAdultsStepper.value))"
        numberOfChildrenLabel.text = "\(Int(numberOfChildrenStepper.value))"
    }
    func updateRoomType(){
        if let roomType = roomType{
            selectRoomTypeDetailLabel.text = roomType.name
        }else {
            selectRoomTypeDetailLabel.text = "No Set"
        }
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
        
    }
    @IBAction func datePickerValueChanged(_ datePicker: UIDatePicker){
        updateDateView()
    }
    @IBAction func stepperValueChanged(_ stepper: UIStepper){
        updateNumOfGuests()
    }
    @IBAction func wifiSwitchChanged(_ switch: UISwitch){
        
    }
    @IBAction func cancelBarButtonTapped(_ button: UIBarButtonItem){
        dismiss(animated: true)
    }
}
