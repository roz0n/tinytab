//
//  AuthLoginResponse.swift
//  Tinytab
//
//  Created by Arnaldo Rozon on 8/3/22.
//

import Foundation

struct AuthLoginResponse: Codable {
  
  var message: String
  
  var success: Bool {
    get {
      return message == "Success." ? true : false
    }
  }
  
}
