//
//  MarkdownParserCore.swift
//  
//
//  Created by Tommi Kivimäki on 04/10/2019.
//

import Foundation

public final class MarkdownParserCore {
  private enum ParserState {
    case text, heading1, heading2, imageCaption, imageURL, code
  }
  
  private var state: ParserState = .text
  public var input: String?
  public var output: [Block] {
    tokenize()
    return blocks
  }
  
  private var blocks = [Block]()
  private var partialBlock: Block?
  
  
  public init(input: String?) {
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
        } else if char == "`" {
          if var partial = partialBlock,
            partial.string.count >= 2,
            partial.string[partial.string.index(before: partial.string.endIndex)] == "`",
            partial.string[partial.string.index(partial.string.endIndex, offsetBy: -2)] == "`" {
            // if the two previous characters were "`"
            
            state = .code
            
            if partial.string.count > 2 {
              // If a codeblock started a line we have collected only "``" which does not need to be stored
              // else if code is inlined with text let's clean up "``" marks and store the text collected this far
              let ticksRange = partial.string.index(partial.string.endIndex, offsetBy: -2)..<partial.string.endIndex
              partial.string.removeSubrange(ticksRange)
              blocks.append(partial)
            }
            partialBlock = nil
            
          } else {
            // "`" scanned, but no code block detected yet.
            // Let's update .text block and see how the future chars look like.
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
            let trimmedPartial = Block.init(kind: partial.kind, string: partial.string.trimmingCharacters(in: .whitespaces))
            blocks.append(trimmedPartial)
            //            blocks.append(partial)
            partialBlock = nil
           }
        } else {
          partialBlock == nil ? partialBlock = Block.heading1Block(String(char)) : partialBlock?.string.append(char)
        }
      case .heading2:
        if char == "\n" {
          state = .text
          if let partial = partialBlock {
            let trimmedPartial = Block.init(kind: partial.kind, string: partial.string.trimmingCharacters(in: .whitespaces))
            blocks.append(trimmedPartial)
//             blocks.append(partial)
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
      case .code:
        if var partial = partialBlock,
          partial.string.count >= 2,
          partial.string[partial.string.index(before: partial.string.endIndex)] == "`",
          partial.string[partial.string.index(partial.string.endIndex, offsetBy: -2)] == "`" {
          // if the two previous characters were "`" remove them
          let ticksRange = partial.string.index(partial.string.endIndex, offsetBy: -2)..<partial.string.endIndex
          partial.string.removeSubrange(ticksRange)
          
//          if partial.string[partial.string.index(before: partial.string.endIndex)] == "\n" {
            if partial.string.last == "\n" {
          // code block has a "\n" as a last character before ending ticks. Remove it
            partial.string.removeLast()
          }
          blocks.append(partial)
          partialBlock = nil
        } else {
          if partialBlock == nil && char != "\n" {
            // Let's create a partialBlock, but let's not do it if we have just "\n"
            partialBlock = Block.codeBlock(String(char))
          } else {
            partialBlock?.string.append(char)
          }
        }
      }
    }
    
    // If there's something in partial block after the processing is over (there's no more input characters) let's copy it to output
    if let partial = partialBlock {
      // Trim white space from headings
      if partial.kind == .heading1 || partial.kind == .heading2 {
        let trimmedPartial = Block.init(kind: partial.kind, string: partial.string.trimmingCharacters(in: .whitespaces))
        blocks.append(trimmedPartial)
      } else {
        blocks.append(partial)
      }
  
      partialBlock = nil
    }
  }
}
