//
//  Favourite.swift
//  NASA_APOD
//
//  Created by Shrikrishna Thodsare on 15/12/25.
//

import Foundation

struct Favourite: Codable, Equatable {
    let title: String
    let imageURL: String
    let date: String
}
