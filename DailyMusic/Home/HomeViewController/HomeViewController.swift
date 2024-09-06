
import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    enum Section {
        case main
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Feed>!
    let homeView = HomeView()
    let homeViewModel = HomeViewModel()
    
    // MARK: - initialize
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBasicAttributes()
        configureCollectionView()
    }
    // MARK: - set basic
    private func setBasicAttributes() {
        view = homeView
        title = "EndYourDay"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(bringUpAddFeedView))
    }
    
    @objc private func bringUpAddFeedView() {
        let addFeedVC = AddFeedViewController()
        let navController = UINavigationController(rootViewController: addFeedVC)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
    }
    
    // MARK: - set and load collectionView
    private func configureCollectionView() {
        dataSource = UICollectionViewDiffableDataSource<Section, Feed>(collectionView: homeView.collectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as? HomeCollectionViewCell else { return UICollectionViewCell() }
            
            cell.configureCell(item)
            return cell
        })
        
        loadFeedData()
        NotificationCenter.default.addObserver(self, selector: #selector(loadFeedData), name: NSNotification.Name("FeedUploaded"), object: nil)
    }
    
    @objc func loadFeedData() {
        HomeView.activityIndicator.startAnimating()
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Feed>()
        snapshot.appendSections([.main])
        homeViewModel.getData { [weak self] feeds in
            guard let self = self else { return }
            snapshot.appendItems(feeds, toSection: .main)
            self.dataSource.apply(snapshot, animatingDifferences: true) {
                HomeView.activityIndicator.stopAnimating()
            }
        }
    }
}

