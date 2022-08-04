//
//  LoginFormController.swift
//  Tinytab
//
//  Created by Arnaldo Rozon on 8/3/22.
//

import UIKit

class LoginFormController: UIViewController {
  
  let apiManager: TinyAPIManager
  
  convenience init() {
    self.init(TinyAPIManager())
  }
  
  init(_ apiManager: TinyAPIManager) {
    self.apiManager = apiManager
    super.init(nibName: nil, bundle: nil)
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
