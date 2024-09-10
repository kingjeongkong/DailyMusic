
import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    let rootView = HomeView()
    let viewModel: HomeViewModel
    let refreshControl = UIRefreshControl()
    
    // MARK: - Life Cycle
    init(homeViewModel: HomeViewModel) {
        self.viewModel = homeViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBasicAttributes()
        bindUI()
    }
    
    // MARK: - Set Basic
    private func setBasicAttributes() {
        view = rootView
        title = "EndYourDay"
        let addFeedBarButton = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                                            style: .plain,
                                                            target: self,
                                                            action: nil)
        addFeedBarButton.accessibilityIdentifier = "plus"
        navigationItem.rightBarButtonItem = addFeedBarButton
        
        rootView.collectionView.refreshControl = refreshControl
    }
    
    private func bindUI() {
        let input = HomeViewModel.Input(refreshEvent: refreshControl.rx.controlEvent(.valueChanged).asObservable())
        
        let output = viewModel.transform(input: input)
        
        let dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, Feed>>(
            configureCell: { _, collectionView, indexPath, item in
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as? HomeCollectionViewCell else { return UICollectionViewCell() }
                cell.configureCell(item)
                return cell
            }
        )
        
        output.feeds
            .map { [SectionModel(model: "DailyMusicSection", items: $0)] }
            .drive(rootView.collectionView.rx.items(dataSource: dataSource))
            .disposed(by: viewModel.disposeBag)
        
        output.feeds
            .drive { [weak self] _ in
                self?.refreshControl.endRefreshing()
            }
            .disposed(by: viewModel.disposeBag)
        
        navigationItem.rightBarButtonItem?.rx.tap
            .bind { [weak self] _ in
                let addFeedVC = AddFeedViewController()
                let navController = UINavigationController(rootViewController: addFeedVC)
                navController.modalPresentationStyle = .fullScreen
                self?.present(navController, animated: true)
            }
            .disposed(by: viewModel.disposeBag)
    }
}
