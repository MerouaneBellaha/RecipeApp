//
//  UIView+cornerRadius.swift
//  RecipeApp
//
//  Created by Merouane Bellaha on 20/09/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import UIKit

extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get { layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }

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


    //
    //    @IBInspectable var shadowRadius: CGFloat = 1.0 {
    //        didSet {
    //            layer.shadowRadius = shadowRadius
    //        }
    //    }
    //
    //    @IBInspectable var masksToBounds: Bool = true {
    //        didSet {
    //            layer.masksToBounds = masksToBounds
    //        }
    //    }
    //
    //    @IBInspectable var shadowOffset: CGSize = CGSize(width: 12, height: 12) {
    //        didSet {
    //            layer.shadowOffset = shadowOffset
    //        }
    //    }
}


