//
//  LoginViewController.swift
//  Tinytab
//
//  Created by Arnaldo Rozon on 8/3/22.
//

import UIKit

final class LoginViewController: UIViewController {
  
  var apiManager: TinyManager
  var formController: LoginFormController
  
  convenience init() {
    self.init(form: LoginFormController(), manager: TinyManager())
  }
  
  init(form formController: LoginFormController, manager apiManager: TinyManager) {
    self.formController = formController
    self.apiManager = apiManager
    
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    presentLoginSheet()
    
#if DEVELOPMENT
    formController.usernameField.text = "a@a.com"
    formController.passwordField.text = "password1234"
#endif
  }
  
  private func setup() {
    configureView()
    configureLoginButton()
  }
  
  private func configureView() {
    view.backgroundColor = .primaryBackground
  }
  
  private func configureLoginButton() {
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedLoginButton(_:)))
    formController.loginButton.addGestureRecognizer(tapGesture)
  }
  
  @objc func tappedLoginButton(_ sender: UITapGestureRecognizer) {
    guard let username = formController.usernameField.text,
          let password = formController.passwordField.text,
          !username.isEmpty,
          !password.isEmpty else {
      presentInvalidLoginAlert()
      return
    }
    
    let user = User(username: username.lowercased(), password: password)
    
    apiManager.loginUser(user) { result in
      switch result {
        case .success(let response):
          print("Response:")
          print(response)
          // Bounce back to root vc
          //
        case .failure(let error):
          print("Error:")
          print(error)
      }
    }
  }
  
  private func presentLoginSheet() {
    let navigationController = UINavigationController(rootViewController: formController)
    
    navigationController.modalPresentationStyle = .pageSheet
    navigationController.isModalInPresentation = true
    
    if let sheet = navigationController.sheetPresentationController {
      sheet.detents = [.medium()]
      sheet.largestUndimmedDetentIdentifier = .medium
    }
    
    present(navigationController, animated: true, completion: nil)
  }
  
  private func presentInvalidLoginAlert() {
    let alert = UIAlertController(title: "Login Failed",
                                  message: "Invalid username or password. \n Please try again.",
                                  preferredStyle: .alert)
    let action = UIAlertAction(title: "Close", style: .default)
    
    alert.addAction(action)
    formController.present(alert, animated: true)
  }
  
}
