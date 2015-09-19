### COUCHPOTATO ###
_build_couchpotato() {
local VERSION="3.0.1"
local FOLDER="CouchPotatoServer-build-${VERSION}"
local FILE="${VERSION}.tar.gz"
local URL="https://github.com/RuudBurger/CouchPotatoServer/archive/build/${FILE}"

_download_tgz "${FILE}" "${URL}" "${FOLDER}"
mkdir -p "${DEST}/app"
cp -vfaR "target/${FOLDER}/"* "${DEST}/app/"
}

### BUILD ###
_build() {
  _build_couchpotato
  _package
}
