//
//  AddFeedView.swift
//  DailyMusic
//
//  Created by 왕정빈 on 2024/04/16.
//

import UIKit

class AddFeedView: UIView {
    
    // MARK: - properties
    let scrollView = UIScrollView()
    let contentView = UIView()
    let albumImageView = UIImageView()
    let captionTextView = UITextView()
    let activityIndicator = UIActivityIndicatorView()
    
    let placeholderText = "Describe your today..."
    
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
        
        scrollView.do {
            $0.keyboardDismissMode = .interactive
        }
        
        albumImageView.do {
            $0.image = UIImage(systemName: "camera")
            $0.layer.borderWidth = 0.5
            $0.contentMode = .scaleAspectFit
            $0.isUserInteractionEnabled = true
            $0.accessibilityIdentifier = "albumImageView"
        }
        
        captionTextView.do {
            $0.layer.borderWidth = 1
            $0.font = UIFont.systemFont(ofSize: 16)
            $0.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) // 상하좌우 패딩 설정
            $0.delegate = self // delegate 설정
            $0.text = placeholderText // Placeholder 텍스트 설정
            $0.textColor = .lightGray // Placeholder 텍스트 색상 설정
            $0.accessibilityIdentifier = "captionTextView"
        }
        
        activityIndicator.do {
            $0.style = .large
            $0.hidesWhenStopped = true
            $0.accessibilityIdentifier = "activityIndicator"
        }
    }
    
    // MARK: - set UI Layout
    private func setLayout() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        [albumImageView, captionTextView, activityIndicator]
            .forEach { contentView.addSubview($0) }
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.greaterThanOrEqualToSuperview().priority(.low)
        }
        
        albumImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(300)
        }
        
        captionTextView.snp.makeConstraints {
            $0.top.equalTo(albumImageView.snp.bottom).offset(40)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(130)
        }
        
        activityIndicator.snp.makeConstraints { $0.center.equalToSuperview() }
    }
}

extension AddFeedView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.text == placeholderText {
                textView.text = ""
                textView.textColor = .black
            }
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text.isEmpty {
                textView.text = placeholderText
                textView.textColor = .lightGray
            }
        }
}
