//
//  CustomTabBar.swift
//  RecipeApp
//
//  Created by Merouane Bellaha on 04/10/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import UIKit

final class CustomTabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setCustomTabBar()
    }

    private func setCustomTabBar() {
        tabBar.clipsToBounds = true
        tabBar.barTintColor = #colorLiteral(red: 0.9411764706, green: 0.9490196078, blue: 0.9254901961, alpha: 1)

        let layer = CAShapeLayer()
        layer.path = UIBezierPath(roundedRect: CGRect(x: 30, y: tabBar.bounds.minY + 5, width: tabBar.bounds.width - 60, height: tabBar.bounds.height + 10), cornerRadius: (tabBar.frame.width/2)).cgPath
        layer.borderWidth = 5
        layer.opacity = 1.0
        layer.isHidden = false
        layer.masksToBounds = false
        layer.fillColor = UIColor.white.cgColor

        tabBar.layer.insertSublayer(layer, at: 0)

        if let items = tabBar.items {
            items.forEach { $0.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -15, right: 0) }
        }

        tabBar.itemWidth = 30.0
        tabBar.itemPositioning = .automatic
    }
}

