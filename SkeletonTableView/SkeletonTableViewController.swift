//
//  SkeletonTableViewController.swift
//  SkeletonTableView
//
//  Created by Jake Robinson-Lieberman on 3/10/20.
//  Copyright © 2020 Jake Robinson-Lieberman. All rights reserved.
//

import Foundation
import UIKit
import SkeletonView

class SkeletonableTableViewController<Cell: SkeletonCell, ViewModel: SkeletonListViewModel>: UITableViewController, SkeletonTableViewDataSource where Cell.Model == ViewModel.Model {

    let viewModel: ViewModel

    lazy var start: Void = {
        viewModel.start()
    }()

    var showingSkeleton: Bool = false {
        didSet {
            if oldValue == showingSkeleton {
                return
            }

            if showingSkeleton {
                tableView.showAnimatedSkeleton()
            } else {
                tableView.hideSkeleton()
            }
        }
    }

    init(viewModel: ViewModel) {
        self.viewModel = viewModel

        super.init(style: .plain)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.isSkeletonable = true

        tableView.register(Cell.self, forCellReuseIdentifier: Cell.identifier)

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        _ = start
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: Cell = tableView.dequeueReusableCell(withIdentifier: Cell.identifier) as! Cell

        let model = viewModel.model(atIndexPath: indexPath)

        return cell.configure(model: model)
    }

    func numSections(in collectionSkeletonView: UITableView) -> Int {
        return numberOfSections(in: collectionSkeletonView)
    }

    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView(tableView, numberOfRowsInSection: section)
    }

    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return Cell.identifier
    }

    func collectionSkeletonView(_ skeletonView: UITableView, identifierForHeaderInSection section: Int) -> ReusableHeaderFooterIdentifier? {
        return nil
    }

    func collectionSkeletonView(_ skeletonView: UITableView, identifierForFooterInSection section: Int) -> ReusableHeaderFooterIdentifier? {
        return nil
    }
}
