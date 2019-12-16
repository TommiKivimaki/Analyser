//
//  Block+HTML.swift
//  
//
//  Created by Tommi Kivimäki on 3.12.2019.
//

import Foundation
import MarkdownParserCore

extension Block {
  func makeHTML() -> String {
    switch self.kind {
    case .text:
      return "<p>\(self.string)</p>"
    case .heading1:
      return "<h1>\(self.string)</h1>"
    case .heading2:
      return "<h2>\(self.string)</h2>"
    case .code:
      return "<pre><code>\(self.string)</code></pre>"
    case .image:
      return "<img src=\"\(self.path ?? "")\" alt=\"\(self.string)\">"
    }
  }
}
