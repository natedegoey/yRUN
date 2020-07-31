//
//  BadgeAnnotation.swift
//  yRUN
//
//  Created by Nathan DeGoey on 2020-07-28.
//  Copyright © 2020 Nathan DeGoey. All rights reserved.
//

import MapKit

class BadgeAnnotation: MKPointAnnotation {
  let imageName: String
  
  init(imageName: String) {
    self.imageName = imageName
    super.init()
  }
}
