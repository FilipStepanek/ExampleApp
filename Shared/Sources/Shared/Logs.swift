//
//  File.swift
//  
//
//  Created by Filip Štěpánek on 26.06.2024.
//

import OSLog

public extension Logger {
    /// Using your bundle identifier is a great way to ensure a unique identifier.
    private static var subsystem = Bundle.main.bundleIdentifier!
    
    /// Logs for networking information.
    static let networking = Logger(subsystem: subsystem, category: "network")
    
    /// Logs the view cycles like a view that appeared.
    static let viewCycle = Logger(subsystem: subsystem, category: "viewcycle")
    
    /// Logs the view cycles like a view that appeared.
    static let dataFlow = Logger(subsystem: subsystem, category: "dataFlow")

    /// All logs related to tracking and analytics.
    static let statistics = Logger(subsystem: subsystem, category: "statistics")
    
    /// All logs related to tracking fetching data from Firebase Database
    static let firebaseData = Logger(subsystem: subsystem, category: "firebaseData")
}
