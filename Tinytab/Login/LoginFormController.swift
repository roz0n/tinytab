//
//  LoginFormController.swift
//  Tinytab
//
//  Created by Arnaldo Rozon on 8/3/22.
//

import UIKit

class LoginFormController: UIViewController {
  
  let headerLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Log in with Square"
    label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
    label.textColor = .primaryBackground
    return label
  }()
  
  let usernameField: LoginTextField = {
    let field = LoginTextField()
    field.translatesAutoresizingMaskIntoConstraints = false
    field.placeholder = "Username"
    field.heightAnchor.constraint(equalToConstant: 56).isActive = true
    field.keyboardType = .emailAddress
    return field
  }()
  
  let passwordField: LoginTextField = {
    let field = LoginTextField()
    field.translatesAutoresizingMaskIntoConstraints = false
    field.placeholder = "Password"
    field.heightAnchor.constraint(equalToConstant: 56).isActive = true
    field.keyboardType = .alphabet
    field.isSecureTextEntry = true
    return field
  }()
  
  let loginButton: UIButton = {
    let button = UIButton(type: .roundedRect)
    button.setTitle("Sign in", for: .normal)
    button.heightAnchor.constraint(equalToConstant: 56).isActive = true
    button.backgroundColor = .accentColor
    button.layer.cornerRadius = 14
    button.layer.masksToBounds = true
    button.tintColor = .white
    button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
    button.titleLabel?.tintColor = .secondaryBodyText
    return button
  }()
  
  let container: UIStackView = {
    let stack = UIStackView()
    stack.translatesAutoresizingMaskIntoConstraints = false
    stack.axis = .vertical
    stack.alignment = .fill
    stack.spacing = 16
    return stack
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  private func setup() {
    configureView()
    applyLayouts()
  }
  
  private func configureView() {
    view.backgroundColor = .primaryForeground
  }
  
}

extension LoginFormController {
  
  func applyLayouts() {
    layoutHeaderLabel()
    layoutContainer()
  }
  
  func layoutHeaderLabel() {
    view.addSubview(headerLabel)
    
    NSLayoutConstraint.activate([
      headerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 24),
      headerLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
      headerLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
    ])
  }
  
  func layoutContainer() {
    view.addSubview(container)
    
    container.addArrangedSubview(usernameField)
    container.addArrangedSubview(passwordField)
    container.addArrangedSubview(loginButton)
    
    NSLayoutConstraint.activate([
      container.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 24),
      container.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
      container.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
    ])
  }
  
}
