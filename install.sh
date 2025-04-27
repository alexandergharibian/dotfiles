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
# Configuration: add or remove stow directories here
# -----------------------------------------------------------------------------
STOW_DIRS=(
  zsh
  git
  vim
)

# Only run on macOS
if [[ "$(uname)" != "Darwin" ]]; then
  echo "⚠️  This installer is intended for macOS." >&2
  exit 1
fi

# Install Homebrew if missing
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew…"
  /bin/bash -c \
    "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Update Homebrew and install required formulae idempotently
brew update
for pkg in "${BREW_PACKAGES[@]}"; do
  if ! brew list --formula | grep -q "^${pkg}\$"; then
    echo "Installing ${pkg}…"
    brew install "${pkg}"
  fi
done

# If user cloned into ~/dotfiles, rename it to ~/.dotfiles
if [[ -d "${HOME}/dotfiles" && ! -d "${HOME}/.dotfiles" ]]; then
  echo "Renaming ~/dotfiles → ~/.dotfiles"
  mv "${HOME}/dotfiles" "${HOME}/.dotfiles"
fi

# Symlink dotfiles with GNU stow
DOTFILES_DIR="${HOME}/.dotfiles"
STOW_TARGET="${HOME}"

if [[ -d "${DOTFILES_DIR}" ]]; then
  pushd "${DOTFILES_DIR}" >/dev/null
  for dir in "${STOW_DIRS[@]}"; do
    echo "Stowing ${dir}…"
    stow --restow --target="${STOW_TARGET}" "${dir}"
  done
  popd >/dev/null
else
  echo "❌  Dotfiles directory not found at ${DOTFILES_DIR}" >&2
  exit 1
fi

echo "✅  Dotfiles installation complete!"
