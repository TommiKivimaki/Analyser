import XCTest
@testable import BlockRenderer
import MarkdownParserCore

#if os(macOS)
import Cocoa
#elseif os(iOS)
import UIKit
#endif


final class BlockRendererTests: XCTestCase {
  
  var blockRenderer: BlockRenderer!
  
  override func setUp() {
    blockRenderer = BlockRenderer()
  }
  
  override func tearDown() {
    blockRenderer = nil
  }
  
  
  func testTextRendering() {
    let input = [Block.textBlock("First block."),
                 Block.textBlock("Second block."),
                 Block.textBlock("Third block.")
    ]
    
    let attributes = StringAttributes.get(for: .text)
    let expectedOutput = [
      NSAttributedString(string: "First block.", attributes: attributes),
      NSAttributedString(string: "Second block.", attributes: attributes),
      NSAttributedString(string: "Third block.", attributes: attributes)]
    
    blockRenderer.input = input
    let result = blockRenderer.renderAsFormattedText()
    
    XCTAssertNotNil(result)
    XCTAssertEqual(result, expectedOutput)
  }
  
  
  func testHeading1Rendering() {
    let input = [Block.heading1Block("First block."),
                 Block.heading1Block("Second block."),
                 Block.heading1Block("Third block.")
    ]
    
    let attributes = StringAttributes.get(for: .heading1)
    let expectedOutput = [
      NSAttributedString(string: "First block.", attributes: attributes),
      NSAttributedString(string: "Second block.", attributes: attributes),
      NSAttributedString(string: "Third block.", attributes: attributes)]
    
    blockRenderer.input = input
    let result = blockRenderer.renderAsFormattedText()
    
    XCTAssertNotNil(result)
    XCTAssertEqual(result, expectedOutput)
  }
  
  
  func testHeading2Rendering() {
    let input = [Block.heading2Block("First block."),
                 Block.heading2Block("Second block."),
                 Block.heading2Block("Third block.")
    ]
    
    let attributes = StringAttributes.get(for: .heading2)
    let expectedOutput = [
      NSAttributedString(string: "First block.", attributes: attributes),
      NSAttributedString(string: "Second block.", attributes: attributes),
      NSAttributedString(string: "Third block.", attributes: attributes)]
    
    blockRenderer.input = input
    let result = blockRenderer.renderAsFormattedText()
    
    XCTAssertNotNil(result)
    XCTAssertEqual(result, expectedOutput)
  }
  
  
  func testCodeRendering() {
    let input = [Block.codeBlock("First block."),
                 Block.codeBlock("Second block."),
                 Block.codeBlock("Third block.")
    ]
    
    let attributes = StringAttributes.get(for: .code)
    let expectedOutput = [
      NSAttributedString(string: "First block.", attributes: attributes),
      NSAttributedString(string: "Second block.", attributes: attributes),
      NSAttributedString(string: "Third block.", attributes: attributes)]
    
    blockRenderer.input = input
    let result = blockRenderer.renderAsFormattedText()
    
    XCTAssertNotNil(result)
    XCTAssertEqual(result, expectedOutput)
  }
  

  func testMixedTextRendering() {
    let input = [Block.heading1Block("I am heading 1"),
                 Block.textBlock("I am text."),
                 Block.heading2Block("I am heading 2"),
                 Block.codeBlock("func passed() -> Bool { return true }")
    ]
    
    let attrHeading1 = StringAttributes.get(for: .heading1)
    let attrHeading2 = StringAttributes.get(for: .heading2)
    let attrText = StringAttributes.get(for: .text)
    let attrCode = StringAttributes.get(for: .code)
    let expectedOutput = [
      NSAttributedString(string: "I am heading 1", attributes: attrHeading1),
      NSAttributedString(string: "I am text.", attributes: attrText),
      NSAttributedString(string: "I am heading 2", attributes: attrHeading2),
      NSAttributedString(string: "func passed() -> Bool { return true }", attributes: attrCode)]
    
    blockRenderer.input = input
    let result = blockRenderer.renderAsFormattedText()
    
    XCTAssertNotNil(result)
    XCTAssertEqual(result, expectedOutput)
  }
  
  
  static var allTests = [
    ("testTextRendering", testTextRendering),
    ("testHeading1Rendering", testHeading1Rendering),
    ("testHeading2Rendering", testHeading2Rendering),
    ("testCodeRendering", testCodeRendering),
    ("testMixedTextRendering", testMixedTextRendering)
  ]
}
