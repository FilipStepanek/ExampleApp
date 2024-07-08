//
//  FirebaseModel.swift
//
//
//  Created by Filip Štěpánek on 26.06.2024.
//

import Foundation

//MARK: Data Structure
public struct SoundsItem: Identifiable {
    public var id: String
    public var artist: String
    public var audioPath: String
    public var category: String
    public var color: String
    public var coverImagePath: String
    public var coverImageUrl: String
    public var title: String
}
