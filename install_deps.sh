#!/bin/bash

sudo apt-get install g++ gcc libc6-dev libffi-dev libgmp-dev make xz-utils zlib1g-dev git gnupg
sudo apt-get install curl

# Stack installation
curl -sSL https://get.haskellstack.org/ | sh
stack install hoogle && hoogle generate
