//
//  HumanTableViewCell.swift
//  SkeletonTableView
//
//  Created by Jake Robinson-Lieberman on 3/10/20.
//  Copyright © 2020 Jake Robinson-Lieberman. All rights reserved.
//

import Foundation
import UIKit

class HumanTableViewCell: UITableViewCell, SkeletonCell {

    static let identifier = "HumanCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)

        commonInit()
    }

    func configure(withSkeleton skeleton: Human) -> Self {
        imageView?.image = .actions
        textLabel?.text = skeleton.name
        detailTextLabel?.text = skeleton.funFact

        return self
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        commonInit()
    }

    func commonInit() {
        isSkeletonable = true
        textLabel?.isSkeletonable = true
        detailTextLabel?.isSkeletonable = true
        imageView?.isSkeletonable = true
    }
}
