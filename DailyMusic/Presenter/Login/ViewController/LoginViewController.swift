//
//  LoginViewController.swift
//  DailyMusic
//
//  Created by 왕정빈 on 9/25/24.
//

import UIKit

final class LoginViewController: UIViewController {
    
    private let rootView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        view = rootView
    }
}
