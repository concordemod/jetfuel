#!/bin/bash
kernel="$(uname -s)"

install_concorde_darwin() {
  instances=()
  for instance in /Applications/Discord*; do
    if [[ "$instance" == "/Applications/Discord.app" || "$instance" == "/Applications/Discord Canary.app" || "$instance" == "/Applications/Discord PTB.app" ]]; then
      instances+=("$instance")
    fi
  done
  echo "Select the Discord instance you want to install Concorde to:"
  select instance in "${instances[@]}"; do
    echo "$instance selected."
    resources="$instance/Contents/Resources/"
    if [ -f "$resources/pre.asar" ]; then
      echo "Error: already patched."
      exit 1
    fi
    echo "Downloading and installing Concorde..."
    mv "$resources/app.asar" "$resources/pre.asar"
    curl -sS https://github.com/concordemod/concorde/releases/latest/download/concorde.asar \
      -o "$resources/app.asar" \
      --location
    if [ ! -d ~/.concorde ]; then
      mkdir -p ~/.concorde/plugins
    fi
    echo "All done. Concorde has been installed."
    exit 0
  done
}

case $kernel in
"Darwin")
  install_concorde_darwin
  ;;
"Linux")
  echo "Linux support soon"
  ;;
esac
