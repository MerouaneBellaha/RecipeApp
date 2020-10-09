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
        // set transparent tabBar
        tabBar.clipsToBounds = true
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()

        let layer = CAShapeLayer()
//        layer.path = UIBezierPath(roundedRect: CGRect(x: 30, y: tabBar.bounds.minY + 5, width: tabBar.bounds.width - 60, height: tabBar.bounds.height + 10), cornerRadius: (tabBar.frame.width/2)).cgPath

        layer.path = UIBezierPath(roundedRect: CGRect(x: 0, y: tabBar.bounds.minY + 5, width: tabBar.bounds.width, height: tabBar.bounds.height + 30), cornerRadius: (tabBar.frame.width/2)).cgPath

        layer.opacity = 1.0
        layer.fillColor = UIColor.white.cgColor

        tabBar.layer.insertSublayer(layer, at: 0)

        if let items = tabBar.items {
            items.forEach { $0.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -15, right: 0) }
        }

        tabBar.itemWidth = 30.0
        tabBar.itemPositioning = .automatic
    }
}

