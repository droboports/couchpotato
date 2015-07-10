### CFFI ###
_build_cffi() {
# also installs pycparser
local VERSION="1.1.2"
local FILE="cffi-${VERSION}-py2.7-linux-armv7l.egg"
local URL="https://github.com/droboports/python-cffi/releases/download/v${VERSION}/${FILE}"
local XPYTHON="${HOME}/xtools/python2/${DROBO}"
export QEMU_LD_PREFIX="${TOOLCHAIN}/${HOST}/libc"

_download_file "${FILE}" "${URL}"
mkdir -p "${DEST}/lib/python2.7/site-packages"
PYTHONPATH="${DEST}/lib/python2.7/site-packages" \
  "${XPYTHON}/bin/easy_install" --prefix="${DEST}" --always-copy "download/${FILE}"
}

### CRYPTOGRAPHY ###
_build_cryptography() {
# also installs ipaddress enum34 six pyasn1 idna
# depends on cffi
local VERSION="0.9.1"
local FILE="cryptography-${VERSION}-py2.7-linux-armv7l.egg"
local URL="https://github.com/droboports/python-cryptography/releases/download/v${VERSION}/${FILE}"
local XPYTHON="${HOME}/xtools/python2/${DROBO}"
export QEMU_LD_PREFIX="${TOOLCHAIN}/${HOST}/libc"

_download_file "${FILE}" "${URL}"
mkdir -p "${DEST}/lib/python2.7/site-packages"
PYTHONPATH="${DEST}/lib/python2.7/site-packages" \
  "${XPYTHON}/bin/easy_install" --prefix="${DEST}" --always-copy "download/${FILE}"
}

### PYOPENSSL ###
_build_pyopenssl() {
# depends on cryptography
local VERSION="0.15.1"
local FILE="pyOpenSSL-${VERSION}-py2.7.egg"
local URL="https://github.com/droboports/python-pyopenssl/releases/download/v${VERSION}/${FILE}"
local XPYTHON="${HOME}/xtools/python2/${DROBO}"
export QEMU_LD_PREFIX="${TOOLCHAIN}/${HOST}/libc"

_download_file "${FILE}" "${URL}"
mkdir -p "${DEST}/lib/python2.7/site-packages"
PYTHONPATH="${DEST}/lib/python2.7/site-packages" \
  "${XPYTHON}/bin/easy_install" --prefix="${DEST}" --always-copy "download/${FILE}"
}

### COUCHPOTATO ###
_build_couchpotato() {
local VERSION="2.6.3.71"
local COMMIT="69825f9dbdfc42d5e6fcebd89828e21ff36330fa"
local FOLDER="CouchPotatoServer-${COMMIT}"
local FILE="${FOLDER}.zip"
local URL="https://github.com/RuudBurger/CouchPotatoServer/archive/${COMMIT}.zip"

_download_zip "${FILE}" "${URL}" "${FOLDER}"
mkdir -p "${DEST}/app"
cp -vfaR "target/${FOLDER}/"* "${DEST}/app/"
}

### BUILD ###
_build() {
  _build_cffi
  _build_cryptography
  _build_pyopenssl
  _build_couchpotato
  _package
}
