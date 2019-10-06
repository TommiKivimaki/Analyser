//
//  MarkdownParserCore.swift
//  
//
//  Created by Tommi Kivimäki on 04/10/2019.
//

import Foundation

class MarkdownParserCore {
  private enum ParserState {
    case text, heading1, heading2, imageCaption, imageURL
  }
  
  private var state: ParserState = .text
  public var input: String?
  public var output: [Block] {
    tokenize()
    return blocks
  }
  
  private var blocks = [Block]()
  private var partialBlock: Block?
  
  init(input: String?) {
    self.input = input
  }
  
  func tokenize() {
    guard let input = input else { return }
    input.forEach { char in
      switch state {
      case .text:
        if char == "#" {
          state = .heading1
        } else if char == "\n" {
          if let partial = partialBlock {
            blocks.append(partial)
            partialBlock = nil
          }
        } else if char == "[" {
          if let partial = partialBlock,
            partial.string.first == "!" {
            state = .imageCaption
            partialBlock = nil
          } else {
            partialBlock == nil ? partialBlock = Block.textBlock(String(char)) : partialBlock?.string.append(char)
          }
        } else {
          partialBlock == nil ? partialBlock = Block.textBlock(String(char)) : partialBlock?.string.append(char)
        }
    
      case .heading1:
        if char == "#" {
          state = .heading2
        } else if char == "\n" {
          state = .text
          if let partial = partialBlock {
             blocks.append(partial)
             partialBlock = nil
           }
        } else {
          partialBlock == nil ? partialBlock = Block.heading1Block(String(char)) : partialBlock?.string.append(char)
        }
      case .heading2:
        if char == "\n" {
          state = .text
          if let partial = partialBlock {
             blocks.append(partial)
             partialBlock = nil
           }
        } else {
          partialBlock == nil ? partialBlock = Block.heading2Block(String(char)) : partialBlock?.string.append(char)
        }
      case .imageCaption:
        if char == "]" {
          // end of caption
          state = .imageURL
        } else {
          // tokenizing the caption
          partialBlock == nil ? partialBlock = Block.imageBlock(String(char)) : partialBlock?.string.append(char)
        }
      case .imageURL:
        if char == ")" {
          // end of url
          if let partial = partialBlock {
            blocks.append(partial)
            partialBlock = nil
          }
        } else if char != "(" {
          // Skip the ( in front of URL
          partialBlock?.path == nil ? partialBlock?.path = String(char) : partialBlock?.path?.append(char)
        }
      }
    }
    
    // If there's something in partial block after the processing is over let's copy it to output
    if let partial = partialBlock {
      blocks.append(partial)
      partialBlock = nil
    }
  }
}

//struct MarkdownParserCore {
//  public var input: String
//  public var output = [Block]()
//  private var state: ParserState
//  var partial: String = ""
//
//  private enum ParserState {
//    case text
//    case heading1
//    case heading2
//  }
//
//  public enum Block {
//    case text(String)
//    case heading1(String)
//    case heading2(String)
//  }
//
//  init(_ input: String) {
//    self.state = .text
//    self.input = input
//  }
//
//  mutating func parse() {
//    input.forEach { char in
//      switch state {
//      case .text:
//        if char == "#" {
//          state = .heading1
//        } else if char == "\n" {
//          let block = Block.text(partial)
//          output.append(block)
//          partial = ""
//          state = .text
//        } else {
//          partial.append(char)
//        }
//      case .heading1:
//        if char == "#" {
//          state = .heading2
//        } else if char == "\n" {
//          state = .text
//        }
//      case .heading2:
//        if char == "\n" {
//          state = .text
//        }
//      }
//    }
//  }
//}
