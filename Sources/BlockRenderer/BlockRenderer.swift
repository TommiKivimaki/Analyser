//
//  BlockRenderer.swift
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

public final class BlockRenderer {
  public var input = [Block]()
  private var output = [NSAttributedString]()
  private var outputHTML = [String]()
  
  public func renderAsFormattedText() -> [NSAttributedString]? {
    input.forEach { block in
      output.append(block.makeNSAttributedString())
    }
    
    return output
  }
  
  public func renderAsHTML() -> [String]? {
    input.forEach { block in
      outputHTML.append(block.makeHTML())
    }
    
    return outputHTML
  }
}
