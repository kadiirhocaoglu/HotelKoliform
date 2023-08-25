//
//  RoomType.swift
//  Hotel Koliform
//
//  Created by Kadir Hocaoğlu on 25.08.2023.
//

import Foundation

struct RoomType: Equatable{
    // MARK: - Properties
    var id: Int
    var name: String
    var shortName: String
    var price: Double
    
    // MARK: - Functions
    static  func ==(lhs: RoomType, rhs: RoomType) -> Bool
    {
        return lhs.id == rhs.id
    }
    
}

