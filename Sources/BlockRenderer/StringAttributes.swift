//
//  StringAttributes.swift
//  
//
//  Created by Tommi Kivimäki on 10/10/2019.
//

import Foundation
import MarkdownParserCore

#if os(macOS)
import Cocoa
#elseif os(iOS)
import UIKit
#endif

public struct StringAttributes {
  
  // For macOS
  #if os(macOS)
  
  public static func get(for kind: Block.Kind) -> [NSAttributedString.Key: Any]? {
    switch kind {
    case .text:
      return [
        .font: NSFont.systemFont(ofSize: 14)]
    case .heading1:
      return [
        .font: NSFont.systemFont(ofSize: 20)]
    case .heading2:
      return [
        .font: NSFont.systemFont(ofSize: 16)]
    case .code:
      return [
        .font: NSFont.systemFont(ofSize: 14)]
    case .image:
      return nil
    }
  }
  
  // For iOS
  #elseif os(iOS)
  
  public func getStringAttributes(for kind: Block.Kind) -> [NSAttributedString.Key: Any]? {
    return nil
  }
  
  #endif
}
