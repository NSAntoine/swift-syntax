//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

@_spi(RawSyntax) import SwiftSyntax

extension RawUnexpectedNodesSyntax {
  /// Returns `true` if this contains a token that satisfies `condition`.
  func containsToken(where condition: (RawTokenSyntax) -> Bool) -> Bool {
    return self.elements.contains(where: { node in
      if let token = node.as(RawTokenSyntax.self) {
        return condition(token)
      } else {
        return false
      }
    })
  }

  /// If `nodes` is not empty, construct a `RawUnexpectedNodesSyntax`
  /// containing those tokens, otherwise return `nil`.
  init?<SyntaxType: RawSyntaxNodeProtocol>(_ nodes: [SyntaxType], arena: SyntaxArena) {
    if nodes.isEmpty {
      return nil
    } else {
      self.init(elements: nodes.map(RawSyntax.init), arena: arena)
    }
  }

  /// If `nodes` contains non-`nil` values, construct a `RawUnexpectedNodesSyntax`
  /// containing those tokens, otherwise return `nil`.
  init?<SyntaxType: RawSyntaxNodeProtocol>(_ nodes: [SyntaxType?], arena: SyntaxArena) {
    self.init(nodes.compactMap({ $0 }), arena: arena)
  }
}

extension SyntaxText {
  var isEditorPlaceholder: Bool {
    return self.starts(with: SyntaxText("<#")) &&
    self.hasSuffix(SyntaxText("#>"))
  }
}

extension RawTokenKind {
  func `is`(any kinds: [RawTokenKind]) -> Bool {
    return kinds.contains(self)
  }
}
