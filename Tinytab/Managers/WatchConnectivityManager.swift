//
//  WatchConnectivityManager.swift
//  Tinytab
//
//  Created by Arnaldo Rozon on 8/11/22.
//

import Foundation
import WatchConnectivity

final class WatchConnectivityManager: NSObject, ObservableObject {
  
  @Published var isWatchSessionActive: Bool = false
  @Published var receivedTextWatch: String?
  @Published var receivedTextPhone: String?
  
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
  
  // MARK: - Networking
  
  func transferUserInfo(_ userInfo: [String: Any]) {
    let session = WCSession.default
    
    if session.activationState == .activated {
      session.transferUserInfo(userInfo)
    }
  }
  
  // WARNING: This only works on a physical device
  func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
    DispatchQueue.main.async { [weak self] in
      if let watchMessageText = userInfo["watch"] as? String {
        self?.receivedTextWatch = watchMessageText
      } else if let phoneMessageText = userInfo["phone"] as? String {
        self?.receivedTextPhone = phoneMessageText
      }
    }
  }
  
  // MARK: - Session
  
#if os(iOS)
  func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    DispatchQueue.main.async {
      if activationState == .activated {
        if session.isWatchAppInstalled {
          print("[iOS] Watch app session successful")
          self.isWatchSessionActive = true
        }
      }
    }
  }
  
  func sessionDidBecomeInactive(_ session: WCSession) {
    DispatchQueue.main.async {
      print("[iOS] Watch connection session is inactive")
      self.isWatchSessionActive = false
    }
  }
  
  func sessionDidDeactivate(_ session: WCSession) {
    DispatchQueue.main.async {
      print("[iOS] Watch session deactivated")
      self.isWatchSessionActive = false
    }
  }
#else
  func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    DispatchQueue.main.async {
      if activationState == .activated {
        print("[watchOS] iPhone found and session is active")
        self.isWatchSessionActive = true
      }
    }
  }
#endif
  
}
