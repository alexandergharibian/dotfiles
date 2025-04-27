#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# -----------------------------------------------------------------------------
# Configuration: add or remove Homebrew packages here
# -----------------------------------------------------------------------------
BREW_PACKAGES=(
  stow
  antidote
)

# -----------------------------------------------------------------------------
# Configuration: add or remove APT packages here (for Debian/Ubuntu)
# -----------------------------------------------------------------------------
LINUX_PACKAGES=(
  stow
  git
  curl
)

# -----------------------------------------------------------------------------
# Configuration: add or remove stow directories here
# -----------------------------------------------------------------------------
STOW_DIRS=(
  zsh
  git
  vim
)

# common dotfiles vars
DOTFILES_DIR="${HOME}/.dotfiles"
STOW_TARGET="${HOME}"

install_mac() {
  echo "Detected macOS…"
  # 1) Homebrew
  if ! command -v brew &>/dev/null; then
    echo "→ Installing Homebrew…"
    /bin/bash -c \
      "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi

  echo "→ Updating Homebrew…"
  brew update

  echo "→ Installing formulae…"
  for pkg in "${BREW_PACKAGES[@]}"; do
    if ! brew list --formula | grep -q "^${pkg}\$"; then
      echo "   • $pkg"
      brew install "$pkg"
    fi
  done
}

install_linux() {
  echo "Detected Linux…"
  # 1) System packages via apt-get (Debian/Ubuntu)
  if command -v apt-get &>/dev/null; then
    echo "→ Updating APT…"
    sudo apt-get update -y
    echo "→ Installing packages…"
    for pkg in "${LINUX_PACKAGES[@]}"; do
      if ! dpkg -s "$pkg" &>/dev/null; then
        echo "   • $pkg"
        sudo apt-get install -y "$pkg"
      fi
    done
  else
    echo "⚠️  Could not find apt-get—please install ${LINUX_PACKAGES[*]} manually." >&2
  fi

  # 2) Antidote (Zsh plugin manager)
  if [[ ! -d "${HOME}/.antidote" ]]; then
    echo "→ Cloning Antidote…"
    git clone https://github.com/mattmc3/antidote.git "${HOME}/.antidote"
  fi
}

# -----------------------------------------------------------------------------
# Main
# -----------------------------------------------------------------------------
OS="$(uname)"
case "$OS" in
  Darwin) install_mac ;;
  Linux)  install_linux ;;
  *)
    echo "❌  Unsupported OS: $OS" >&2
    exit 1
    ;;
esac

# rename ~/dotfiles → ~/.dotfiles if needed
if [[ -d "${HOME}/dotfiles" && ! -d "${DOTFILES_DIR}" ]]; then
  echo "→ Renaming ~/dotfiles → ${DOTFILES_DIR}"
  mv "${HOME}/dotfiles" "${DOTFILES_DIR}"
fi

# stow your directories
if [[ -d "${DOTFILES_DIR}" ]]; then
  pushd "${DOTFILES_DIR}" >/dev/null
  for dir in "${STOW_DIRS[@]}"; do
    echo "→ Stowing ${dir}"
    stow --restow --target="${STOW_TARGET}" "${dir}"
  done
  popd >/dev/null
else
  echo "❌  Dotfiles directory not found at ${DOTFILES_DIR}" >&2
  exit 1
fi

echo "✅  Dotfiles installation complete!"
