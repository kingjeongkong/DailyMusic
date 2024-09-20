//
//  AddFeedViewController.swift
//  DailyMusic
//
//  Created by 왕정빈 on 2024/04/12.
//

import UIKit
import PhotosUI
import RxCocoa
import RxSwift

class AddFeedViewController: UIViewController {
    
    // MARK: - properties
    private let rootView = AddFeedView()
    private let viewModel: AddFeedViewModel
    private let imageRelay = PublishRelay<UIImage>()
    let uploadCompletedToHome = PublishRelay<Void>()
    
    // MARK: - initialize
    init(viewModel: AddFeedViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setInitialAttributes()
        pickImage()
        bindUI()
    }
    
    // MARK: - set initial attributes
    private func setInitialAttributes() {
        view = rootView
        
        let closeBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"),
                                                 style: .plain,
                                                 target: self,
                                                 action: nil)
        let shareBarButtonItem = UIBarButtonItem(title: "공유",
                                                 style: .plain,
                                                 target: self,
                                                 action: nil)
        shareBarButtonItem.accessibilityIdentifier = "공유"
        
        navigationItem.leftBarButtonItem = closeBarButtonItem
        navigationItem.rightBarButtonItem = shareBarButtonItem
    }
    
    private func bindUI() {
        guard let uploadButtonDidTap = navigationItem.rightBarButtonItem?.rx.tap.asObservable() else { return }
        
        let input = AddFeedViewModel.Input(captionText: rootView.captionTextField.rx.text.orEmpty.asObservable(),
                                           musicImage: imageRelay.asObservable(),
                                           uploadButtonDidTap: uploadButtonDidTap)
        
        let output = viewModel.transform(input: input)
        
        output.uploadCompleted
            .drive { [weak self] _ in
                self?.dismiss(animated: true, completion: {
                    self?.uploadCompletedToHome.accept(())
                })
            }
            .disposed(by: viewModel.disposeBag)
        
        output.uploadFailed
            .drive { error in
                print(error.localizedDescription)
            }
            .disposed(by: viewModel.disposeBag)
        
        output.isUploading
            .drive { [weak self] isUploading in
                if isUploading {
                    self?.rootView.activityIndicator.startAnimating()
                } else {
                    self?.rootView.activityIndicator.stopAnimating()
                }
            }
            .disposed(by: viewModel.disposeBag)

        
        navigationItem.leftBarButtonItem?.rx.tap
            .bind(onNext: { [weak self] _ in
                self?.dismiss(animated: true)
            })
            .disposed(by: viewModel.disposeBag)
    }
    
    // MARK: - imagePick
    private func pickImage() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedImageView))
        rootView.albumImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func tappedImageView() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
}

extension AddFeedViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        picker.dismiss(animated: true)
        
        guard let itemProvider = results.first?.itemProvider else { return }
        
        if itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                DispatchQueue.main.async {
                    guard let image = image as? UIImage else { return }
                    self?.rootView.albumImageView.image = image
                    self?.imageRelay.accept(image)
                }
            }
        }
    }
}
