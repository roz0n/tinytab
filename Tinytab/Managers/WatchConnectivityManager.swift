//
//  WatchConnectivityManager.swift
//  Tinytab
//
//  Created by Arnaldo Rozon on 8/11/22.
//

import Foundation
import WatchConnectivity

final class WatchConnectivityManager: NSObject, ObservableObject {
  
  @Published var isLoggedIn: Bool = false
  
  override init() {
    super.init()
    
    if WCSession.isSupported() {
      let session = WCSession.default
      
      session.delegate = self
      session.activate()
    }
  }
  
}

// MARK: - WatchConnectivityManager + WCSessionDelegate

extension WatchConnectivityManager: WCSessionDelegate {
  
#if os(iOS)
  func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    DispatchQueue.main.async {
      if activationState == .activated {
        if session.isWatchAppInstalled {
          print("[iOS] Watch app session successful")
          self.isLoggedIn = true
        }
      }
    }
  }
  
  func sessionDidBecomeInactive(_ session: WCSession) {
    DispatchQueue.main.async {
      print("[iOS] Watch connection session is inactive")
      self.isLoggedIn = false
    }
  }
  
  func sessionDidDeactivate(_ session: WCSession) {
    DispatchQueue.main.async {
      print("[iOS] Watch session deactivated")
      self.isLoggedIn = false
    }
  }
#else
  func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    DispatchQueue.main.async {
      if activationState == .activated {
        print("[watchOS] iPhone found and session is active")
        self.isLoggedIn = true
      }
    }
  }
#endif
  
}
