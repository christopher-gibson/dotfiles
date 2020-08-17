# GPG is needed for nodejs plugin
brew install asdf gpg android-sdk

asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git

asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
# Imports Node.js release team's OpenPGP keys to main keyring
bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring

asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git

asdf install nodejs latest
asdf global nodejs latest

# Install yarn but use asdf managed node
brew install yarn --ignore-dependencies
