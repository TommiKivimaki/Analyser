//
//  Analyser.swift
//  
//
//  Created by Tommi Kivimäki on 4.12.2019.
//

import Foundation
import MarkdownParserCore
import BlockRenderer

public final class Analyser {
  
  public init() {}
  
  public func convertToHTML(_ markdown: String) -> String {
    let parser = MarkdownParserCore(input: markdown)
    let blocks = parser.output
    
    let renderer = BlockRenderer(blocks)
    guard let strings = renderer.renderAsHTML() else {
      return ""
    }
    
    return strings.reduce("", +)
  }
  
}
