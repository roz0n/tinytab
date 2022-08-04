//
//  LoginResponse.swift
//  Tinytab
//
//  Created by Arnaldo Rozon on 8/3/22.
//

import Foundation

struct LoginResponse: Codable {
  
  private var message: String
  
  var success: Bool {
    // TODO: Convince femi to use boolean values for things like this
    get {
      return message == "Success." ? true : false
    }
  }
  
}
