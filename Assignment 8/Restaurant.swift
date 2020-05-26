//
//  Restaurant.swift
//  Assignment 8
//
//  Created by 桑染 on 2020-05-25.
//  Copyright © 2020 Rick. All rights reserved.
//

import UIKit

struct Restaurant {
    let image: UIImage?
    let name: String
    let category: Category
    
    enum Category {
        case all
        case Philippines
        case Vietnam
        case Mexico
        case Italy
        case France
        case Japan
        case Portugal
    }
}

extension Restaurant.Category: CaseIterable { }

extension Restaurant.Category: RawRepresentable {
    typealias RawValue = String
  
  init?(rawValue: String) {
        switch rawValue {
        case "All": self = .all
        case "Philippines": self = .Philippines
        case "Vietnam": self = .Vietnam
        case "Mexico": self = .Mexico
        case "Italy": self = .Italy
        case "France": self = .France
        case "Japan": self = .Japan
        case "Portugal": self = .Portugal
      default:
        return nil
    }
  }
  
  var rawValue: String {
        switch self {
        case .all: return "All"
        case .Philippines: return "Philippines"
        case .Vietnam: return "Vietnam"
        case .Mexico: return "Mexico"
        case .Italy: return "Italy"
        case .France: return "France"
        case .Japan: return "Japan"
        case .Portugal: return "Portugal"
    }
  }
}
