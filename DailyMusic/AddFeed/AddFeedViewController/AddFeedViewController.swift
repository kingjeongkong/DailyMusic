//
//  AddFeedViewController.swift
//  DailyMusic
//
//  Created by 왕정빈 on 2024/04/12.
//

import UIKit
import SnapKit
import Then

class AddFeedViewController: UIViewController {
    
    // MARK: - properties
    private let addFeedView = AddFeedView()
    private let addFeedViewModel = AddFeedViewModel()
    private let imagePicker = UIImagePickerController()
    
    // MARK: - initialize
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setInitialAttributes()
        pickImage()
    }
    
    // MARK: - set initial attributes
    private func setInitialAttributes() {
        view = addFeedView
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(poptoMain))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "공유",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(uploadFeed))
    }
    
    @objc private func poptoMain() {
        dismiss(animated: true)
    }
    
    @objc private func uploadFeed() {
        dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            HomeView.activityIndicator.startAnimating()
            self.addFeedViewModel.uploadFeed(image: addFeedView.albumImageView.image, caption: addFeedView.captionTextField.text) {
                NotificationCenter.default.post(name: NSNotification.Name("FeedUploaded"), object: nil)
            }
        }
    }
    
    // MARK: - imagePick
    private func pickImage() {
        addFeedView.albumImageView.isUserInteractionEnabled = true
        imagePicker.delegate = self
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedImageView))
        addFeedView.albumImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func tappedImageView() {
        self.imagePicker.sourceType = .photoLibrary
        self.imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
}

extension AddFeedViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicker.dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
            self.addFeedView.albumImageView.image = editedImage
        }
    }
}
