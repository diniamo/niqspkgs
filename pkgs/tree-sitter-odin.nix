{tree-sitter, fetchFromGitHub}: tree-sitter.buildGrammar {
  language = "tree-sitter-odin";
  version = "0-unstable-d2ca8ef";
  
  src = fetchFromGitHub {
    owner = "tree-sitter-grammars";
    repo = "tree-sitter-odin";
    rev = "d2ca8efb4487e156a60d5bd6db2598b872629403";
    hash = "sha256-aPeaGERAP1Fav2QAjZy1zXciCuUTQYrsqXaSQsYG0oU=";
  };
  
  meta.homepage = "https://github.com/amaanq/tree-sitter-odin";
}
