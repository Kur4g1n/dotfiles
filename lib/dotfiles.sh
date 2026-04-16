banner() {
  echo "=== $1"
}

installing_banner() {
  banner "Installing $1"
}

is_installed() {
  command -v "$1" >/dev/null 2>&1
}

config_banner() {
  banner "Configuring $1"
}

skipping() {
  echo "Skipping $1"
}
