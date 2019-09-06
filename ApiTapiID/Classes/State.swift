//
//  State.swift
//  ApiTapiID
//
//  Created by Appbooster on 03/09/2019.
//  Copyright © 2019 Appbooster. All rights reserved.
//

import Foundation

struct State {

  static var showDebug: Bool = false
  static var log: ((String) -> Void)?

  static var deviceToken: String? {
    get {
      if let value = Keychain.load(key: #function) {
        UserDefaults.standard.set(value, forKey: #function)
        UserDefaults.standard.synchronize()
      }

      return UserDefaults.standard.string(forKey: #function)
    }
    set(newValue) {
      if let value = newValue {
        if Keychain.load(key: #function) == nil {
          if !Keychain.save(key: #function, value: value) {
            debugAndLog("[ApiTapiID] deviceToken saving in keychain error")
          }
        } else {
          if !Keychain.update(key: #function, value: value) {
            debugAndLog("[ApiTapiID] deviceToken updating in keychain error")
          }
        }
      } else {
        if !Keychain.remove(key: #function) {
          debugAndLog("[ApiTapiID] deviceToken removing from keychain error")
        }
      }

      UserDefaults.standard.set(newValue, forKey: #function)
      UserDefaults.standard.synchronize()
    }
  }

  // MARK: Service

  private static func debugAndLog(_ text: String) {
    if showDebug {
      #if DEBUG
      print(text)
      #endif
    }

    log?(text)
  }

}
