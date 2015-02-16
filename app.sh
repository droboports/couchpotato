### COUCHPOTATO ###
_build_couchpotato() {
local BRANCH="master"
local FOLDER="app"
local URL="https://github.com/RuudBurger/CouchPotatoServer.git"

_download_git "${BRANCH}" "${FOLDER}" "${URL}"
mkdir -p "${DEST}/app"
cp -avR "target/${FOLDER}"/* "${DEST}/app/"
}

### BUILD ###
_build() {
  _build_couchpotato
  _package
}
