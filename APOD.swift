//
//  APOD.swift
//  NASA_APOD
//
//  Created by Shrikrishna Thodsare on 15/12/25.
//


import Foundation

struct APOD: Codable {
    let title: String
    let explanation: String
    let url: String
    let date: String
    let media_type: String
    let hdurl: String?
}
