
import UIKit

protocol SkeletonCell {
    static var identifier: String { get }
}

protocol SkeletonListViewModel {
    func start()
}

class HumanListTableViewController: SkeletonableTableViewController<HumanTableViewCell, HumanListViewModel> {

    override init(viewModel: HumanListViewModel) {
        super.init(viewModel: viewModel)

        viewModel.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Humans"

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .fastForward,
                                                            target: self,
                                                            action: #selector(rightBarButtonItemTapped))
    }

    @objc func rightBarButtonItemTapped() {
        viewModel.switchInstance()
    }

    func viewModel(_ viewModel: HumanListViewModel, didUpdateHumans humans: [Human]?) {
        showingSkeleton = humans == nil

        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HumanTableViewCell = tableView.dequeueReusableCell(withIdentifier: HumanTableViewCell.identifier) as! HumanTableViewCell

        let human = viewModel.human(atIndexPath: indexPath)

        return cell.configure(withSkeleton: human)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(inSection: section)
    }
}
