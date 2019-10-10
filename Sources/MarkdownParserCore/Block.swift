//
//  Block.swift
//  
//
//  Created by Tommi Kivimäki on 04/10/2019.
//

import Foundation

public struct Block {
  public enum Kind { case text, heading1, heading2, image, code }
  
  public let kind: Kind
  public var string: String
  public var path: String? = nil
}

extension Block {
  public static func textBlock(_ string: String) -> Block {
    return Block(kind: .text, string: string)
  }
  
  public static func heading1Block(_ string: String) -> Block {
    return Block(kind: .heading1, string: string)
  }
  
  public static  func heading2Block(_ string: String) -> Block {
    return Block(kind: .heading2, string: string)
  }
  
  public static func imageBlock(_ string: String) -> Block {
    return Block(kind: .image, string: string)
  }
  
  public static func codeBlock(_ string: String) -> Block {
    return Block(kind: .code, string: string)
  }
}


extension Block: Equatable {
  public static func ==(lhs: Block, rhs: Block) -> Bool {
    return lhs.kind == rhs.kind && lhs.string == rhs.string && lhs.path == rhs.path
  }
}
