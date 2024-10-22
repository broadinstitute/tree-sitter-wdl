package tree_sitter_wdl_test

import (
	"testing"

	tree_sitter "github.com/tree-sitter/go-tree-sitter"
	tree_sitter_wdl "git+github.com/jdidion/tree-sitter-wdl.git/bindings/go"
)

func TestCanLoadGrammar(t *testing.T) {
	language := tree_sitter.NewLanguage(tree_sitter_wdl.Language())
	if language == nil {
		t.Errorf("Error loading Wdl grammar")
	}
}
