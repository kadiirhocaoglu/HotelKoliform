//
//  SelectRoomTypeTableViewController.swift
//  Hotel Koliform
//
//  Created by Kadir Hocaoğlu on 30.08.2023.
//

import UIKit

protocol SelectRoomTypeTableViewControllerDelegate: class{
    func didSelect(roomType: RoomType)
}
class SelectRoomTypeTableViewController: UITableViewController {

    // MARK: - UI Elements
    
    // MARK: - Properties
    var selectedRoom: RoomType?
    weak var delegate: SelectRoomTypeTableViewControllerDelegate?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RoomType.all.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellForRoom")!
        let roomType = RoomType.all[indexPath.row]
        if roomType == selectedRoom{
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        
        cell.textLabel?.text = roomType.name
        cell.detailTextLabel?.text = "€ \(roomType.price)"
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedRoom = RoomType.all[indexPath.row]
        if let selectedRoom = selectedRoom{
            delegate?.didSelect(roomType: selectedRoom)
        }
        delegate?.didSelect(roomType: selectedRoom!)
        tableView.reloadData()
        
    }
    
    // MARK: - Actions
    

}
