//
//  SplashViewController.swift
//  ProfileAppTest
//
//  Created by Максим Хмелев on 20.09.2022.
//

import UIKit

class SplashViewController: UIViewController {
    
    let splashImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "profile")
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(splashImageView)
        splashImageView.frame = view.frame
    }
}
