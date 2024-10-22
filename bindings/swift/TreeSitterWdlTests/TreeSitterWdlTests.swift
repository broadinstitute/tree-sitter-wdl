import XCTest
import SwiftTreeSitter
import TreeSitterWdl

final class TreeSitterWdlTests: XCTestCase {
    func testCanLoadGrammar() throws {
        let parser = Parser()
        let language = Language(language: tree_sitter_wdl())
        XCTAssertNoThrow(try parser.setLanguage(language),
                         "Error loading Wdl grammar")
    }
}
