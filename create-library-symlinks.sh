function symlink-library {
  name=$1

  echo
  echo "Symlinking $name"
  echo "- - -"

  for entry in ../libraries/raygun_client*; do
    echo "- removing symlink: $entry"
    rm $entry
  done

  echo "- creating symlinks"
  ln -s $(PWD)/lib/raygun_client* $(PWD)/../libraries/

  echo "- - -"
  echo "($name done)"
  echo
}
