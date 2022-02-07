//
//  NetworkLaunchModel.swift
//  SpaceXLaunchCase
//
//  Created by BarisOdabasi on 7.02.2022.
//

import Foundation

struct NetworkLaunchModel: Codable {
    var name: String?
    var details: String?
    var success: Bool?
    var flight_number: Int?
    var links: Links?
}


struct Links: Codable {
    var patch: Patch?
}

struct Patch: Codable {
    var small: URL?
    var large: URL?
}
