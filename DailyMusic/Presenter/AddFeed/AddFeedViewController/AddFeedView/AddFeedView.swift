//
//  AddFeedView.swift
//  DailyMusic
//
//  Created by 왕정빈 on 2024/04/16.
//

import UIKit

class AddFeedView: UIView {
    
    // MARK: - properties
    let albumImageView = UIImageView()
    let captionTextField = UITextField()
    let activityIndicator = UIActivityIndicatorView()

    // MARK: - initialize
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - set UI properties
    private func setUI() {
        backgroundColor = .systemBackground
        
        albumImageView.do {
            $0.image = UIImage(systemName: "camera")
            $0.layer.borderWidth = 0.5
            $0.contentMode = .scaleAspectFit
            $0.isUserInteractionEnabled = true
            $0.accessibilityIdentifier = "albumImageView"
        }
        
        captionTextField.do {
            $0.text = "New Test Caption" 
            $0.layer.borderWidth = 1
            $0.addPadding(left: 5, right: 5)
            $0.accessibilityIdentifier = "captionTextField"
        }
        
        activityIndicator.do {
            $0.style = .large
            $0.hidesWhenStopped = true
            $0.accessibilityIdentifier = "activityIndicator"
        }
    }
    
    // MARK: - set UI Layout
    private func setLayout() {
        [albumImageView, captionTextField, activityIndicator]
            .forEach { addSubview($0) }
        
        albumImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(200)
        }
        
        captionTextField.snp.makeConstraints {
            $0.top.equalTo(albumImageView.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(keyboardLayoutGuide.snp.top).offset(-50)
        }
        
        activityIndicator.snp.makeConstraints { $0.center.equalToSuperview() }
    }
}
