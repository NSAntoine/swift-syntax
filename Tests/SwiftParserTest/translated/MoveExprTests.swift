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

// This test file has been translated from swift/test/Parse/move_expr.swift

import XCTest

final class MoveExprTests: XCTestCase {
  func testMoveExpr1() {
    AssertParse(
      """
      var global: Int = 5
      func testGlobal() {
          let _ = _move global
      }
      """
    )
  }

  func testMoveExpr2() {
    AssertParse(
      """
      func testLet() {
          let t = String()
          let _ = _move t
      }
      """
    )
  }

  func testMoveExpr3() {
    AssertParse(
      """
      func testVar() {
          var t = String()
          t = String()
          let _ = _move t
      }
      """
    )
  }

}
