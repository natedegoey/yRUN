//
//  Badge.swift
//  yRUN
//
//  Created by Nathan DeGoey on 2020-07-28.
//  Copyright © 2020 Nathan DeGoey. All rights reserved.
//

import Foundation

// This defines the Badge structure and provides a failable initializer to extract the information from the JSON object.
struct Badge {
  let name: String
  let imageName: String
  let information: String
  let distance: Double
  
  init?(from dictionary: [String: String]) {
    guard
      let name = dictionary["name"],
      let imageName = dictionary["imageName"],
      let information = dictionary["information"],
      let distanceString = dictionary["distance"],
      let distance = Double(distanceString)
    else {
      return nil
    }
    self.name = name
    self.imageName = imageName
    self.information = information
    self.distance = distance
  }
    
    // You use basic JSON deserialization to extract the data from the file and compactMap to discard any structures which fail to initialize. allBadges is declared static so that the expensive parsing operation happens only once.
    static let allBadges: [Badge] = {
      guard let fileURL = Bundle.main.url(forResource: "badges", withExtension: "txt") else {
        fatalError("No badges.txt file found")
      }
      do {
        let jsonData = try Data(contentsOf: fileURL, options: .mappedIfSafe)
        let jsonResult = try JSONSerialization.jsonObject(with: jsonData) as! [[String: String]]
        return jsonResult.compactMap(Badge.init)
      } catch {
        fatalError("Cannot decode badges.txt")
      }
    }()
    
    // Each of these methods filters the list of badges depending on whether they have been earned or are, as yet, unearned.
    static func best(for distance: Double) -> Badge {
      return allBadges.filter { $0.distance < distance }.last ?? allBadges.first!
    }

    static func next(for distance: Double) -> Badge {
      return allBadges.filter { distance < $0.distance }.first ?? allBadges.last!
    }

    
}

extension Badge: Equatable {
  static func ==(lhs: Badge, rhs: Badge) -> Bool {
    return lhs.name == rhs.name
  }
}

