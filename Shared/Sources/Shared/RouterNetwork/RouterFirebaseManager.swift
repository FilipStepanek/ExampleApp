//
//  RouterFirebaseManager.swift
//
//
//  Created by Filip Štěpánek on 26.06.2024.
//

import Foundation
import FirebaseStorage
import CoreLocation

enum RouterFirebaseManager {
    case fetchImageURLs
    case fetchAudioURLs
}

extension RouterFirebaseManager: Router {
    var baseURL: URL {
        Constants.baseURL
    }

    var path: String {
            switch self {
            case .fetchImageURLs:
                return "sounds/images/"
            case .fetchAudioURLs:
                return "sounds/audio/"
            }
        }

    var method: HTTPMethod {
        .get
    }

    var urlParameters: [String: Any]? {
        nil
    }
    
    var headers: [String: String]? {
        nil
    }

    var acceptableStatusCodes: Range<HTTPStatusCode>? {
        nil
    }

    var isAuthorizationRequired: Bool {
        true
    }
}

