//
//  BadgeCell.swift
//  yRUN
//
//  Created by Nathan DeGoey on 2020-07-28.
//  Copyright © 2020 Nathan DeGoey. All rights reserved.
//

import UIKit

class BadgeCell: UITableViewCell {
  
  @IBOutlet weak var badgeImageView: UIImageView!
  @IBOutlet weak var silverImageView: UIImageView!
  @IBOutlet weak var goldImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var earnedLabel: UILabel!
  
  var status: BadgeStatus! {
    didSet {
      configure()
    }
  }
    
    private let redLabel = #colorLiteral(red: 1, green: 0.07843137255, blue: 0.1725490196, alpha: 1)
    private let greenLabel = #colorLiteral(red: 0, green: 0.5725490196, blue: 0.3058823529, alpha: 1)
    private let badgeRotation = CGAffineTransform(rotationAngle: .pi / 8)
      
    private func configure() {
      silverImageView.isHidden = status.silver == nil
      goldImageView.isHidden = status.gold == nil
      if let earned = status.earned {
        nameLabel.text = status.badge.name
        nameLabel.textColor = greenLabel
        let dateEarned = FormatDisplay.date(earned.timestamp)
        earnedLabel.text = "Earned: \(dateEarned)"
        earnedLabel.textColor = greenLabel
        badgeImageView.image = UIImage(named: status.badge.imageName)
        silverImageView.transform = badgeRotation
        goldImageView.transform = badgeRotation
        isUserInteractionEnabled = true
        accessoryType = .disclosureIndicator
      } else {
        nameLabel.text = "?????"
        nameLabel.textColor = redLabel
        let formattedDistance = FormatDisplay.distance(status.badge.distance)
        earnedLabel.text = "Run \(formattedDistance) to earn"
        earnedLabel.textColor = redLabel
        badgeImageView.image = nil
        isUserInteractionEnabled = false
        accessoryType = .none
        selectionStyle = .none
      }
    }

}
