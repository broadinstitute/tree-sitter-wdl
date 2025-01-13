# tree-sitter-wdl

[Tree-sitter](https://github.com/tree-sitter/tree-sitter) grammar for [WDL](https://openwdl.org/) (Workflow Description Language).
Supports WDL version 1.0 and 1.1. Tree-sitter grammars are often used by code editors for syntax highlighting, code folding, 
and much more.

Examples:

* WDL extension for [Zed](https://zed.dev): [zed-wdl](https://github.com/broadinstitute/zed-wdl)

## Acknowledgements

This repository is based on the [tree-sitter-wdl](https://github.com/jdidion/tree-sitter-wdl) from John Didion, who wrote the 
vast majority of the grammar. This repository fixes a couple of things:

* Add support for WDL 1.0 sep="", true="", false="", and default="" place holder options (e.g., `${sep="," file_names}`)
* Fix parsing of escaped characters in command blocks, which caused some bash scripts to be parsed incorrectly.

## Bindings

Tree-sitter grammers can be used with many different programming languages, and this repository contains bindings
to Rust, Python, Node.js, Go, Swift, and C. Example usage of the Rust bindings is shown below.

### Rust binding examples

See the [Tree-sitter documentation](https://tree-sitter.github.io/tree-sitter/using-parsers) for the list of available language bindings and basic usage information. To use the [Rust binding](https://crates.io/crates/tree-sitter-wdl-1), add the following to your Cargo.toml:

```toml
[dependencies]
tree-sitter-wdl-1 = "0.1.0"
```

A convenience function is provided to create a new TreeSitter parser with the language set to `tree-sitter-wdl-1`:

```rust
use tree_sitter_wdl_1 as wdl;

fn main() {
    let parser = wdl::parser().expect("Error creating WDL parser");
    ...
}
```

There is also a convenience function to parse a single document into a `tree_sitter::Tree`:

```rust
use tree_sitter::Tree;
use tree_sitter_wdl_1 as wdl;

fn main() {
    let text = r#"
    version 1.0

    workflow foo {
    }
    "#;
    let tree: Tree = wdl::parse_document(text).expect("Error parsing WDL parser");
    ...
}
```

## Design

This repository provides a single [grammar](grammar.js) that parses WDL versions `1.x` (`draft-*` and `development` versions are *not* supported). The grammar is designed to be permissive and error-tolerant. A parser generated from this grammar will allow token combinations that are forbidden by the WDL specification or that are only allowed in certain WDL versions.

As Tree-sitter generates LR(1) parsers, only one token of look-ahead is available and thus syntax elements that require multiple tokens of look-ahead are difficult or impossible to write. For WDL, this means strings (including the contents of the `command` block) cannot be described by the grammar. Fortunately, Tree-sitter allows for external parsing of these syntax elements. The external parser for the WDL grammar is in [scanner.cc](src/tree_sitter/../scanner.cc) and implements the API described in the [Tree-sitter documentation](https://tree-sitter.github.io/tree-sitter/creating-parsers#external-scanners).

## Development

* Follow the instructions to install the [Tree-sitter CLI](https://github.com/tree-sitter/tree-sitter/blob/master/cli/README.md)
* Generate and compile the parser: `npm run build`
* Run the tests `npm run test`