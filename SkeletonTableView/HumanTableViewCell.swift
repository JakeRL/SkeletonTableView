//
//  HumanTableViewCell.swift
//  SkeletonTableView
//
//  Created by Jake Robinson-Lieberman on 3/10/20.
//  Copyright © 2020 Jake Robinson-Lieberman. All rights reserved.
//

import Foundation
import UIKit

class HumanTableViewCell: UITableViewCell {

    static let identifier = "HumanCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)

        isSkeletonable = true
        textLabel?.isSkeletonable = true
        detailTextLabel?.isSkeletonable = true
        imageView?.isSkeletonable = true
    }

    func configure(withSkeleton skeleton: Human) -> Self {
        textLabel?.text = skeleton.name
        detailTextLabel?.text = skeleton.funFact

        return self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
