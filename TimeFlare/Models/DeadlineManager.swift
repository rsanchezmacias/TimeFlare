//
//  DeadlineManager.swift
//  TimeFlare
//
//  Created by Ricardo Sanchez-Macias on 8/28/23.
//

import Foundation

protocol DeadlineManagerProtocol {
    func deleteAll()
}

class DeadlineManager: DeadlineManagerProtocol {
    
    func deleteAll() {
        print("Deleting all deadlines for the user...w")
    }
    
}
