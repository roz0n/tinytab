//
//  LoginTextField.swift
//  Tinytab
//
//  Created by Arnaldo Rozon on 8/4/22.
//

import UIKit

class LoginTextField: UITextField {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setup() {
    configureField()
  }
  
  private func configureField() {
    backgroundColor = .clear
    textColor = .secondaryBodyText
    layer.cornerRadius = 14
    layer.masksToBounds = true
    layer.borderColor = UIColor.systemGray.withAlphaComponent(0.25).cgColor
    layer.borderWidth = 1
    leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
    leftViewMode = .always
  }
  
}
