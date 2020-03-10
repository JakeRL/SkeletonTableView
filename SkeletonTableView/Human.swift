//
//  Human.swift
//  SkeletonTableView
//
//  Created by Jake Robinson-Lieberman on 3/10/20.
//  Copyright © 2020 Jake Robinson-Lieberman. All rights reserved.
//

import Foundation

struct Human: Skeleton {
    let name: String
    let funFact: String

    static var skeleton: Human { Human(name: .skeletonString, funFact: .skeletonString) }
}

protocol Skeleton {
    static var skeleton: Self { get }
}

extension String {
    static var skeletonString: String {
        return String(UUID().uuidString.map { _ in " " })
    }
}
