//
//  HomeCollectionViewCell.swift
//  DailyMusic
//
//  Created by 왕정빈 on 2024/03/02.
//

import UIKit
import SnapKit
import Then
import Kingfisher

class HomeCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI components
    let userImage = UIImageView()
    let userName = UILabel()
    let musicView = UIImageView()
    let captionLabel = UILabel()
    let numOfListening = UILabel()
    let listeningImage = UIImageView()
    let numOfLikes = UILabel()
    let likesImage = UIImageView()
    let numOfComments = UILabel()
    let commentsImage = UIImageView()
    let borderLine = UIView()
    
    let listeningStack = UIStackView()
    let responseStack = UIStackView()

    // MARK: - initialize
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set UI
    private func setUI() {
        [listeningImage, numOfListening].forEach { listeningStack.addArrangedSubview($0) }
        [likesImage, numOfLikes, commentsImage, numOfComments].forEach { responseStack.addArrangedSubview($0) }
        
        [userImage, userName, musicView, captionLabel, listeningStack, responseStack, borderLine]
            .forEach { addSubview($0) }
        
        userImage.do {
            $0.image = UIImage(systemName: "person")
            $0.backgroundColor = .black
            $0.layer.cornerRadius = 20
            $0.clipsToBounds = true
        }
        
        userName.do {
            $0.text = "Jack"
            $0.font = .boldSystemFont(ofSize: 20)
        }
        
        musicView.do {
            $0.backgroundColor = .systemBlue
        }
        
        captionLabel.do {
            $0.numberOfLines = 0
            $0.font = .systemFont(ofSize: 18)
        }
        
        numOfLikes.do {
            $0.text = "12"
            $0.font = .systemFont(ofSize: 15)
        }
        
        likesImage.do {
            $0.image = UIImage(systemName: "heart")
        }
        
        numOfComments.do {
            $0.text = "5"
            $0.font = .systemFont(ofSize: 15)
        }
        
        commentsImage.do {
            $0.image = UIImage(systemName: "bubble.right")
        }
        
        responseStack.do {
            $0.axis = .horizontal
            $0.setCustomSpacing(2, after: likesImage)
            $0.setCustomSpacing(10, after: numOfLikes)
            $0.setCustomSpacing(3, after: commentsImage)
        }
        
        numOfListening.do {
            $0.text = "32"
            $0.font = .systemFont(ofSize: 15)
        }
        
        listeningImage.do {
            $0.image = UIImage(systemName: "headphones")
        }
        
        listeningStack.do {
            $0.axis = .horizontal
            $0.setCustomSpacing(3, after: listeningImage)
        }
        
        borderLine.do { $0.backgroundColor = .lightGray }
    }
    
    private func setLayout() {
        userImage.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(20)
            $0.width.height.equalTo(40)
        }
        
        userName.snp.makeConstraints {
            $0.leading.equalTo(userImage.snp.trailing).offset(15)
            $0.centerY.equalTo(userImage)
        }
        
        musicView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(userImage.snp.bottom).offset(10)
            $0.height.equalTo(350).priority(.high)
        }
        
        captionLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.top.equalTo(musicView.snp.bottom).offset(15)
        }
        
        responseStack.snp.makeConstraints {
            $0.top.equalTo(captionLabel.snp.bottom).offset(15)
            $0.leading.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview().offset(-10)
        }
        
        likesImage.snp.makeConstraints { $0.width.height.equalTo(30) }
        commentsImage.snp.makeConstraints { $0.width.height.equalTo(30) }
        listeningImage.snp.makeConstraints { $0.width.height.equalTo(30) }
        
        listeningStack.snp.makeConstraints {
            $0.top.equalTo(responseStack)
            $0.trailing.equalToSuperview().offset(-25)
            $0.bottom.equalTo(responseStack)
        }
        
        borderLine.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(0.5)
        }
    }
    
    // MARK: - Binding Data
    func configureCell(_ feed: Feed) {
        captionLabel.text = feed.caption
        musicView.kf.setImage(with: URL(string: feed.imageURL ?? ""))
    }
}
