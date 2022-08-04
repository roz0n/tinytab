//
//  LoginFormController.swift
//  Tinytab
//
//  Created by Arnaldo Rozon on 8/3/22.
//

import UIKit

class LoginFormController: UIViewController {
  
  let apiManager: TinyManager
  
  let headerLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Log in with Square"
    label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
    label.textColor = .primaryBackground
    return label
  }()
  
  let usernameField: UITextField = {
    let field = UITextField()
    field.translatesAutoresizingMaskIntoConstraints = false
    field.placeholder = "Username"
    field.backgroundColor = .systemPurple
    field.heightAnchor.constraint(equalToConstant: 56).isActive = true
    return field
  }()
  
  let passwordField: UITextField = {
    let field = UITextField()
    field.translatesAutoresizingMaskIntoConstraints = false
    field.placeholder = "Password"
    field.backgroundColor = .systemIndigo
    field.heightAnchor.constraint(equalToConstant: 56).isActive = true
    return field
  }()
  
  let loginButton: UIButton = {
    let button = UIButton(type: .roundedRect)
    button.setTitle("Sign in", for: .normal)
    button.heightAnchor.constraint(equalToConstant: 56).isActive = true
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
  
  convenience init() {
    self.init(TinyManager())
  }
  
  init(_ apiManager: TinyManager) {
    self.apiManager = apiManager
    super.init(nibName: nil, bundle: nil)
    applyLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .primaryForeground
    navigationController?.navigationBar.tintColor = .primaryBodyText
    
    let mockUser = User(username: "arnaldo", password: "666")
    
    apiManager.loginUser(mockUser) { result in
      switch result {
        case .success(let response):
          print("Response:")
          print(response)
        case .failure(let error):
          print("Error:")
          print(error)
      }
    }
  }
  
}

extension LoginFormController {
  
  func applyLayout() {
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
