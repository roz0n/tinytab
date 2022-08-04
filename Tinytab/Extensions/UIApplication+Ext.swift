//
//  UIApplication+Ext.swift
//  Tinytab
//
//  Created by Arnaldo Rozon on 8/4/22.
//

import UIKit

@nonobjc extension UIApplication {
  
  var sceneDelegate: SceneDelegate? {
    return UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
  }
  
}
