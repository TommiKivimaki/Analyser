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
  
  //
  // HTML Rendering tests
  //
  
  func testHTMLTextRendering() {
     let input = [Block.textBlock("First block."),
                  Block.textBlock("Second block."),
                  Block.textBlock("Third block.")
     ]
     
     let expectedOutput = ["<p>First block.</p>",
                           "<p>Second block.</p>",
                           "<p>Third block.</p>"]
     
     blockRenderer.input = input
     let result = blockRenderer.renderAsHTML()
     
     XCTAssertNotNil(result)
     XCTAssertEqual(result, expectedOutput)
   }
   
   
   func testHTMLHeading1Rendering() {
     let input = [Block.heading1Block("First block."),
                  Block.heading1Block("Second block."),
                  Block.heading1Block("Third block.")
     ]
     
     let expectedOutput = ["<h1>First block.</h1>",
                           "<h1>Second block.</h1>",
                           "<h1>Third block.</h1>"]
     
     blockRenderer.input = input
     let result = blockRenderer.renderAsHTML()
     
     XCTAssertNotNil(result)
     XCTAssertEqual(result, expectedOutput)
   }
   
   
   func testHTMLHeading2Rendering() {
     let input = [Block.heading2Block("First block."),
                  Block.heading2Block("Second block."),
                  Block.heading2Block("Third block.")
     ]
     
     let expectedOutput = ["<h2>First block.</h2>",
                           "<h2>Second block.</h2>",
                           "<h2>Third block.</h2>"]
     
     blockRenderer.input = input
     let result = blockRenderer.renderAsHTML()
     
     XCTAssertNotNil(result)
     XCTAssertEqual(result, expectedOutput)
   }
   
   
   func testHTMLCodeRendering() {
     let input = [Block.codeBlock("First block."),
                  Block.codeBlock("Second block."),
                  Block.codeBlock("Third block.")
     ]
     
     let expectedOutput = ["<pre><code>First block.</code></pre>",
                           "<pre><code>Second block.</code></pre>",
                           "<pre><code>Third block.</code></pre>"]
     
     blockRenderer.input = input
     let result = blockRenderer.renderAsHTML()
     
     XCTAssertNotNil(result)
     XCTAssertEqual(result, expectedOutput)
   }
   

   func testHTMLMixedTextRendering() {
     let input = [Block.heading1Block("I am heading 1"),
                  Block.textBlock("I am text."),
                  Block.heading2Block("I am heading 2"),
                  Block.codeBlock("func passed() -> Bool { return true }")
     ]
     
    
    let expectedOutput = ["<h1>I am heading 1</h1>",
                          "<p>I am text.</p>",
                          "<h2>I am heading 2</h2>",
                          "<pre><code>func passed() -> Bool { return true }</code></pre>"]
    
    blockRenderer.input = input
    let result = blockRenderer.renderAsHTML()
     
     XCTAssertNotNil(result)
     XCTAssertEqual(result, expectedOutput)
   }
  
  
  static var allTests = [
    ("testTextRendering", testTextRendering),
    ("testHeading1Rendering", testHeading1Rendering),
    ("testHeading2Rendering", testHeading2Rendering),
    ("testCodeRendering", testCodeRendering),
    ("testMixedTextRendering", testMixedTextRendering),
    ("testHTMLTextRendering", testHTMLTextRendering),
    ("testHTMLHeading1Rendering", testHTMLHeading1Rendering),
    ("testHTMLHeading2Rendering", testHTMLHeading2Rendering),
    ("testHTMLCodeRendering", testHTMLCodeRendering),
    ("testHTMLMixedTextRendering", testHTMLMixedTextRendering)
  ]
}
