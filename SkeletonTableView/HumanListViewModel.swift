//
//  HumanListViewModel.swift
//  SkeletonTableView
//
//  Created by Jake Robinson-Lieberman on 3/10/20.
//  Copyright © 2020 Jake Robinson-Lieberman. All rights reserved.
//

import Foundation

class HumanListViewModel {

    var loadingData: Bool { humans == nil }

    weak var delegate: HumanListTableViewController?

    var humans: [Human]? {
        didSet {
            delegate?.viewModel(self, didUpdateHumans: humans)
        }
    }

    func start() {
        humans = nil

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.humans = Array(repeating: Human(name: "Bob", funFact: "Likes tomatoes"), count: 100)
        }
    }

    func human(atIndexPath indexPath: IndexPath) -> Human {
        guard let humans = self.humans, indexPath.row < humans.count else {
            return .skeleton
        }

        return humans[indexPath.row]
    }

    var numberOfSections: Int { 1 }

    func numberOfRows(inSection: Int) -> Int {
        return humans?.count ?? 25
    }

    func switchInstance() {
        start()
    }
}
