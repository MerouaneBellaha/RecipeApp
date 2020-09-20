//
//  UIView+shadow.swift
//  RecipeApp
//
//  Created by Merouane Bellaha on 20/09/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import UIKit

extension UIView {
    
    @IBInspectable
    var shadowColor: UIColor {
        get { UIColor(cgColor: layer.shadowColor ?? UIColor.gray.cgColor) }
        set { layer.shadowColor = newValue.cgColor }
    }

    @IBInspectable
    var shadowOpacity: Float {
        get { layer.shadowOpacity }
        set { layer.shadowOpacity = newValue }
    }

    @IBInspectable
    var shadowRadius: CGFloat {
        get { layer.shadowRadius }
        set { layer.shadowRadius = newValue }
    }

    @IBInspectable
    var shadowOffset: CGSize {
        get { layer.shadowOffset }
        set { layer.shadowOffset = newValue }
    }
}
