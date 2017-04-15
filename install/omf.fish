#!/usr/bin/env fish

omf install

set packages nvm osx nvm rbenv foreign-env android-sdk bobthefish

for p in $packages; omf install $p; end
omf theme bobthefish
