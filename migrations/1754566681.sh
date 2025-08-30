echo "Make new Osaka Jade theme available as new default"

if [[ ! -L ~/.config/osvmarchi/themes/osaka-jade ]]; then
  rm -rf ~/.config/osvmarchi/themes/osaka-jade
  git -C ~/.local/share/osvmarchi checkout -f themes/osaka-jade
  ln -nfs ~/.local/share/osvmarchi/themes/osaka-jade ~/.config/osvmarchi/themes/osaka-jade
fi
