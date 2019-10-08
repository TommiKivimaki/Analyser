import XCTest
@testable import MarkdownParserCore

final class MarkdownParserCoreTests: XCTestCase {

  var parserCore: MarkdownParserCore!
  
  override func setUp() {
    parserCore = MarkdownParserCore(input: nil)
  }
  
  override func tearDown() {
    parserCore = nil
  }


  func testTextSingleLine() {
    parserCore.input = """
                       Moro
                       """
    
    let expectedOutput = [Block(kind: .text, string: "Moro")]
    XCTAssertEqual(parserCore.output, expectedOutput)
  }
  
  func testTextMultipleLines() {
     parserCore.input = """
                        Moro! Hei vaan.
                        
                        Tässä toinen rivi.
                        """
     
     let expectedOutput = [Block(kind: .text, string: "Moro! Hei vaan."),
                           Block(kind: .text, string: "Tässä toinen rivi.")]
     XCTAssertEqual(parserCore.output, expectedOutput)
   }
  
  func testTextWithTicks() {
    parserCore.input = """
                       ``
                       """
    
    let expectedOutput = [Block(kind: .text, string: "``")]
    XCTAssertEqual(parserCore.output, expectedOutput)
  }
  
  func testHeadline1SingleLine() {
    parserCore.input = """
                       #Otsikko 1 A
                       """
    
    let expectedOutput = [Block(kind: .heading1, string: "Otsikko 1 A")]
    XCTAssertEqual(parserCore.output, expectedOutput)
  }
  
  func testHeadline1MultipleLines() {
    parserCore.input = """
                       #Headline
                       # Headline 2
                       """
    
    let expectedOutput = [Block(kind: .heading1, string: "Headline"),
                          Block(kind: .heading1, string: " Headline 2")]
    XCTAssertEqual(parserCore.output, expectedOutput)
  }
  
  func testHeadline2SingleLine() {
    parserCore.input = """
                       ##Headline number two
                       """
    
    let expectedOutput = [Block(kind: .heading2, string: "Headline number two")]
    XCTAssertEqual(parserCore.output, expectedOutput)
  }
  
  func testHeadlinesAndText() {
    parserCore.input = """
                       #Headline
                       
                       Then some text.
                       ##Another headline
                       And more text.
                       """
    
    let expectedOutput = [Block(kind: .heading1, string: "Headline"),
                          Block(kind: .text, string: "Then some text."),
                          Block(kind: .heading2, string: "Another headline"),
                          Block(kind: .text, string: "And more text.")]
    XCTAssertEqual(parserCore.output, expectedOutput)
  }
  
  func testImage() {
    parserCore.input = """
                       ![image](link)
                       """
    
    let expectedOutput = [Block(kind: .image, string: "image", path: "link")]
    XCTAssertEqual(parserCore.output, expectedOutput)
  }
  
  func testCodeInline() {
    parserCore.input = """
                 Text ```code```
                 """
    
    let expectedOutput = [Block(kind: .text, string: "Text "),
                          Block(kind: .code, string: "code")]
    XCTAssertEqual(parserCore.output, expectedOutput)
  }
  
  func testCodeBlock() {
    parserCore.input = """
                       ```
                       line 1
                       line 2
                       ```
                       """
    
    let expectedOutput = [Block(kind: .code, string: "line 1\nline 2")]
    XCTAssertEqual(parserCore.output, expectedOutput)
  }
  
  func testEmptyCodeBlock() {
    parserCore.input = """
                       ```
                       ```
                       """
    
    let expectedOutput = [Block(kind: .code, string: "")]
    XCTAssertEqual(parserCore.output, expectedOutput)
  }
  
  
      static var allTests = [
          ("testTextSingleLine", testTextSingleLine),
          ("testTextMultipleLines", testTextMultipleLines),
          ("testHeadline1SingleLine", testHeadline1SingleLine),
          ("testHeadline1MultipleLines", testHeadline1MultipleLines),
          ("testHeadline2SingleLine", testHeadline2SingleLine),
          ("testHeadlinesAndText", testHeadlinesAndText),
          ("testImage", testImage),
          ("testCodeInline", testCodeInline),
          ("testCodeBlock", testCodeBlock),
          ("testEmptyCodeBlock", testEmptyCodeBlock)
      ]
}
