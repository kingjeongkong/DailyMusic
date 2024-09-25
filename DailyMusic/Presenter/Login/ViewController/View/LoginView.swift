//
//  LoginView.swift
//  DailyMusic
//
//  Created by 왕정빈 on 9/25/24.
//

import UIKit
import Then
import SnapKit

final class LoginView: UIView {
    
    let loginButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setHierarchy() {
        [loginButton]
            .forEach{ addSubview($0) }
    }
    
    private func setUI() {
        loginButton.do {
            $0.setTitle("Login", for: .normal)
            $0.backgroundColor = .lightGray
            $0.titleLabel?.font = .boldSystemFont(ofSize: 25)
        }
    }
    
    private func setLayouy() {
        loginButton.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
