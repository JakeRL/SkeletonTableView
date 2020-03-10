
import UIKit
import SkeletonView

class HumanListTableViewController: UITableViewController, SkeletonTableViewDataSource {

    var humans: [Human]? {
        didSet {
            if humans != nil {
                view.hideSkeleton()
            }

            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Humans"

        tableView.isSkeletonable = true

        tableView.register(SkeletonCell.self, forCellReuseIdentifier: SkeletonCell.identifier)

        tableView.isUserInteractionEnabled = true
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44

        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.humans = [Human(name: "Bob", funFact: "Likes tomatoes"), Human(name: "Sally", funFact: "Hates tomatoes")]
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        if view.isSkeletonActive && humans != nil { return }
        view.showAnimatedSkeleton()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SkeletonCell = tableView.dequeueReusableCell(withIdentifier: SkeletonCell.identifier) as! SkeletonCell

        let human: Human
        if let humans = self.humans, indexPath.row < humans.count {
            human = humans[indexPath.row]
        } else {
            human = .skeleton
        }

        return cell.configure(withSkeleton: human)
    }

    override func numberOfSections(in tableView: UITableView) -> Int { 1 }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { humans?.count ?? 100 }

    func numSections(in collectionSkeletonView: UITableView) -> Int { numberOfSections(in: collectionSkeletonView) }
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int { tableView(tableView, numberOfRowsInSection: section) }
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier { SkeletonCell.identifier }
    func collectionSkeletonView(_ skeletonView: UITableView, identifierForHeaderInSection section: Int) -> ReusableHeaderFooterIdentifier? { nil }
    func collectionSkeletonView(_ skeletonView: UITableView, identifierForFooterInSection section: Int) -> ReusableHeaderFooterIdentifier? { nil }
}

class SkeletonCell: UITableViewCell {

    static let identifier = "SkeletonCell"

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

struct Human: Skeleton {
    let name: String
    let funFact: String

    static var skeleton: Human { Human(name: UUID().uuidString, funFact: UUID().uuidString) }
}

protocol Skeleton {
    static var skeleton: Self { get }
}
