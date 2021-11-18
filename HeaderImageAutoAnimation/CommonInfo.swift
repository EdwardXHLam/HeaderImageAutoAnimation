//
//  CommonInfo.swift
//  HeaderImageAutoAnimation
//
//  Created by YZ-LXH on 2021/11/11.
//

import Foundation
import UIKit

// 屏幕宽度
let GKPage_Screen_Width = UIScreen.main.bounds.size.width

// 屏幕高度
let GKPage_Screen_Height = UIScreen.main.bounds.size.height


/**
 设置圆角
 */
func RadiusToView(view: UIView, radius: CGFloat) {
    
    view.layer.cornerRadius = radius
    
    view.layer.masksToBounds = true
}

/**
 设置圆角和加边框
 */
func BorderRadiusToView(view: UIView, radius: CGFloat, width: CGFloat, color: UIColor) {
    
    view.layer.cornerRadius = radius
    
    view.layer.masksToBounds = true
    
    view.layer.borderWidth = width
    
    view.layer.borderColor = color.cgColor
}


