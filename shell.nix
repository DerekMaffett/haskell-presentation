let
  pkgs = import <nixpkgs> {};
in
pkgs.mkShell {
  name="presentation";
  buildInputs=[
    pkgs.fswatch
    (pkgs.writeScriptBin "run" ".slides/$(tmux display-message -p '#W')")
    (pkgs.writeScriptBin "present" "create-interactive-slideshow ./slides.hs && tmuxinator start -p ./.slides/.slideshow.yml")
    (pkgs.writeScriptBin "watch" "stack ghc ./.slides/$1; fswatch -r -o -l 0.2 ./.slides/$1.hs | (while read; do stack ghc ./.slides/$1.hs; done)")
  ];
}
