//
//  WebsiteDescription.swift
//  Networking
//
//  Created by Roman Korobskoy on 19.11.2021.
//

import Foundation

struct WebsiteDescription: Decodable {
    let websiteDescription: String?
    let websiteName: String?
    let courses: [Course]?
}
