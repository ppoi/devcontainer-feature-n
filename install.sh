#/bin/bash -i

set -e

curl -fsSL https://raw.githubusercontent.com/tj/n/master/bin/n | bash -s $VERSION
npm install -g n