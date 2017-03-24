//
//  ServiceError.swift
//  POECGameDetails
//
//  Created by Apple on 23/03/2017.
//  Copyright © 2017 M2i. All rights reserved.
//

import Foundation

// enum des Exceptions de service
enum ServiceError : Error {
    case requestFailed
    case wrongData(message : String)
}
