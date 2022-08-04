//
//  LoginViewController.swift
//  Tinytab
//
//  Created by Arnaldo Rozon on 8/3/22.
//

import UIKit

final class LoginViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    presentLoginSheet()
  }
  
  private func setup() {
    configureView()
  }
  
  private func configureView() {
    view.backgroundColor = .primaryBackground
  }
  
  private func presentLoginSheet() {
    let formController = LoginFormController()
    let navigationController = UINavigationController(rootViewController: formController)
    navigationController.modalPresentationStyle = .pageSheet
    
    if let sheet = navigationController.sheetPresentationController {
      sheet.detents = [.medium()]
      sheet.largestUndimmedDetentIdentifier = .medium
    }
    
    present(navigationController, animated: true, completion: nil)
  }
  
}
