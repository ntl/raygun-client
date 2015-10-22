function local-gem-path {
  if [[ ! $GEM_PATH == *"./gems"* ]]; then
    export GEM_PATH=./gems:$GEM_PATH
    echo "Gem path is: $GEM_PATH"
  fi
}

# function local-gems {
  echo
  echo 'Installing local gems'
  echo '= = ='

  local-gem-path

  echo
  echo 'Removing gem files'
  echo '- - -'
  for gem in *.gem; do
    rm $gem
  done

  echo
  echo 'Building gems'
  echo '- - -'
  for gemspec in *.gemspec; do
    gem build $gemspec
  done

  echo
  echo 'Installing gems locally'
  echo '- - -'
  for gem in *.gem; do
    gem install $gem --source https://gem.fury.io/obsidian/ --install-dir ./gems --development
  done

  echo
  echo '= = ='
  echo
# }
