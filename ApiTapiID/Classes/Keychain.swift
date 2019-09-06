//
//  Keychain.swift
//  ApiTapiID
//
//  Created by Appbooster on 03/09/2019.
//  Copyright © 2019 Appbooster. All rights reserved.
//

import Foundation
import Security

private let kSecClassValue: NSString = NSString(format: kSecClass)
private let kSecAttrAccountValue: NSString = NSString(format: kSecAttrAccount)
private let kSecValueDataValue: NSString = NSString(format: kSecValueData)
private let kSecClassGenericPasswordValue: NSString = NSString(format: kSecClassGenericPassword)
private let kSecAttrServiceValue: NSString = NSString(format: kSecAttrService)
private let kSecMatchLimitValue: NSString = NSString(format: kSecMatchLimit)
private let kSecReturnDataValue: NSString = NSString(format: kSecReturnData)
private let kSecMatchLimitOneValue: NSString = NSString(format: kSecMatchLimitOne)

private let service: String = "ApiTapiID"

struct Keychain {

  static func load(key: String) -> String? {
    let query: NSDictionary = [
      kSecClassValue: kSecClassGenericPasswordValue,
      kSecAttrServiceValue: service,
      kSecAttrAccountValue: key,
      kSecReturnDataValue: kCFBooleanTrue ?? true,
      kSecMatchLimitValue: kSecMatchLimitOneValue
    ]

    var dataTypeRef: AnyObject?
    let status: OSStatus = SecItemCopyMatching(query, &dataTypeRef)
    var value: String?

    if status == errSecSuccess {
      if let data = dataTypeRef as? Data {
        value = String(data: data, encoding: .utf8)
      }
    }

    return value
  }

  static func save(key: String, value: String) -> Bool {
    guard let data = value.data(using: .utf8, allowLossyConversion: false) else {
      return false
    }

    let query: NSDictionary = [
      kSecClassValue: kSecClassGenericPasswordValue,
      kSecAttrServiceValue: service,
      kSecAttrAccountValue: key,
      kSecValueDataValue: data
    ]
    let status = SecItemAdd(query as CFDictionary, nil)

    return status == errSecSuccess
  }

  static func update(key: String, value: String) -> Bool {
    guard let data = value.data(using: .utf8, allowLossyConversion: false) else {
      return false
    }

    let query: NSDictionary = [
      kSecClassValue: kSecClassGenericPasswordValue,
      kSecAttrServiceValue: service,
      kSecAttrAccountValue: key
    ]
    let status = SecItemUpdate(query as CFDictionary, [kSecValueDataValue: data] as CFDictionary)

    return status == errSecSuccess
  }

  static func remove(key: String) -> Bool {
    let query: NSDictionary = [
      kSecClassValue: kSecClassGenericPasswordValue,
      kSecAttrServiceValue: service,
      kSecAttrAccountValue: key,
      kSecReturnDataValue: kCFBooleanTrue ?? true
    ]
    let status = SecItemDelete(query as CFDictionary)

    return status == errSecSuccess
  }

}
