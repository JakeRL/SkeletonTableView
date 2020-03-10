
import UIKit
import SkeletonView

class HumanListTableViewController: UITableViewController, SkeletonTableViewDataSource {

    let humanListViewModel: HumanListViewModel

    lazy var start: Void = {
        humanListViewModel.start()
    }()

    init(humanListViewModel: HumanListViewModel) {
        self.humanListViewModel = humanListViewModel

        super.init(style: .plain)

        humanListViewModel.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Humans"

        tableView.isSkeletonable = true

        tableView.register(HumanTableViewCell.self, forCellReuseIdentifier: HumanTableViewCell.identifier)

        // seemingly unnecessary but noted as 'mandatory' by the readme
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .fastForward,
                                                            target: self,
                                                            action: #selector(rightBarButtonItemTapped))
    }

    @objc func rightBarButtonItemTapped() {
        humanListViewModel.switchInstance()
    }

    func viewModel(_ viewModel: HumanListViewModel, didUpdateHumans humans: [Human]?) {
        if humans != nil {
            tableView.hideSkeleton()
        }

        tableView.reloadData()

        if humans == nil {
            tableView.showSkeleton()
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        _ = start
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HumanTableViewCell = tableView.dequeueReusableCell(withIdentifier: HumanTableViewCell.identifier) as! HumanTableViewCell

        let human = humanListViewModel.human(atIndexPath: indexPath)

        return cell.configure(withSkeleton: human)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return humanListViewModel.numberOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return humanListViewModel.numberOfRows(inSection: section)
    }

    func numSections(in collectionSkeletonView: UITableView) -> Int {
        return numberOfSections(in: collectionSkeletonView)
    }

    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView(tableView, numberOfRowsInSection: section)
    }

    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return HumanTableViewCell.identifier
    }

    func collectionSkeletonView(_ skeletonView: UITableView, identifierForHeaderInSection section: Int) -> ReusableHeaderFooterIdentifier? {
        return nil
    }

    func collectionSkeletonView(_ skeletonView: UITableView, identifierForFooterInSection section: Int) -> ReusableHeaderFooterIdentifier? {
        return nil
    }
}
