//
//  TinyManager.swift
//  Tinytab
//
//  Created by Arnaldo Rozon on 8/3/22.
//

import Foundation

final class TinyManager {
  
  enum TinyAPIError: Error {
    case invalidCredentials
    case invalidResponse
    case malformedData
  }
  
  public let session = URLSession.shared
  
#if DEVELOPMENT
  var endpoint: String {
    get {
      // TODO: Grab this value from a plist to make setting it more intuitive?
      return "https://rozon.ngrok.io/api"
    }
  }
#else
  var endpoint: String {
    get {
      // TODO: Swap this value for a prod url later
      return "https://www.prodtiny.io"
    }
  }
#endif
  
  public func loginUser(_ user: User, completion: @escaping (Result<LoginResponse, Error>) -> Void) {
    guard let url = URL(string: "\(endpoint)/auth/app/login"),
          let body = try? JSONEncoder().encode(user) else {
      completion(.failure(TinyAPIError.invalidCredentials))
      return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "content-type")
    request.httpBody = body
    
    session.dataTask(with: request) { data, response, error in
      if let error = error {
        completion(.failure(error))
        return
      }
      
      guard let response = response as? HTTPURLResponse,
            response.statusCode == 200 else {
        completion(.failure(TinyAPIError.invalidResponse))
        return
      }
      
      guard let data = data else {
        completion(.failure(TinyAPIError.malformedData))
        return
      }
      
      do {
        let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
        completion(.success(loginResponse))
      } catch {
        completion(.failure(error))
      }
    }.resume()
  }
  
}
