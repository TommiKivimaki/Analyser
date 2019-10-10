//
//  Block+NSAttributedStrings.swift
//  
//
//  Created by Tommi Kivimäki on 09/10/2019.
//

import Foundation
import MarkdownParserCore

#if os(macOS)
import Cocoa
#elseif os(iOS)
import UIKit
#endif

extension Block {
  func makeNSAttributedString() -> NSAttributedString {
    var attributes: [NSAttributedString.Key: Any]?
    
    switch self.kind {
    case .text:
      attributes = StringAttributes.get(for: .text)
    case .heading1:
      attributes = StringAttributes.get(for: .heading1)
    case .heading2:
      attributes = StringAttributes.get(for: .heading2)
    case .code:
      attributes = StringAttributes.get(for: .code)
    case .image:
      attributes = nil
    }
    
    return NSAttributedString(string: self.string, attributes: attributes)
  }
}
