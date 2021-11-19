//
//  Course.swift
//  Networking
//
//  Created by Roman Korobskoy on 19.11.2021.
//

import Foundation

struct Course: Decodable {
    let id: Int?
    let name: String?
    let link: String?
    let imageUrl: String?
    let numberOfLessons: Int?
    let numberOfTests: Int?
}
