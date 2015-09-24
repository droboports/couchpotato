### LXML ###
_build_lxml() {
local VERSION="3.4.4"
local FILE="lxml-${VERSION}-py2.7-linux-armv7l.egg"
local URL="https://github.com/droboports/python-lxml/releases/download/v${VERSION}/${FILE}"
local XPYTHON="${HOME}/xtools/python2/${DROBO}"
export QEMU_LD_PREFIX="${TOOLCHAIN}/${HOST}/libc"

_download_file "${FILE}" "${URL}"
mkdir -p "${DEST}/lib/python2.7/site-packages"
PYTHONPATH="${DEST}/lib/python2.7/site-packages" \
  "${XPYTHON}/bin/easy_install" --prefix="${DEST}" \
  --always-unzip --always-copy "download/${FILE}"
}

### python2 module ###
# Build a python2 module from source
__build_module() {
local VERSION="${2}"
local FOLDER="${1}-${VERSION}"
local FILE="${FOLDER}.tar.gz"
local URL="https://pypi.python.org/packages/source/$(echo ${1} | cut -c 1)/${1}/${FILE}"
local HPYTHON="${DROBOAPPS}/python2"
local XPYTHON="${HOME}/xtools/python2/${DROBO}"
export QEMU_LD_PREFIX="${TOOLCHAIN}/${HOST}/libc"

_download_tgz "${FILE}" "${URL}" "${FOLDER}"
pushd "target/${FOLDER}"
sed -e "s/from distutils.core import setup/from setuptools import setup/g" \
    -i setup.py
PKG_CONFIG_PATH="${XPYTHON}/lib/pkgconfig" \
  LDFLAGS="${LDFLAGS} -Wl,-rpath,${HPYTHON}/lib -L${XPYTHON}/lib" \
  PYTHONPATH="${DEST}/lib/python2.7/site-packages" \
  "${XPYTHON}/bin/python" setup.py \
    build_ext --include-dirs="${XPYTHON}/include" --library-dirs="${XPYTHON}/lib" --force \
    build --force \
    build_scripts --executable="${HPYTHON}/bin/python" --force \
    install --prefix="${DEST}"
popd
}

### DEPENDENCIES ###
_build_modules() {
  mkdir -p "${DEST}/lib/python2.7/site-packages"

        __build_module pycparser 2.14
      __build_module cffi 1.2.1
      __build_module ipaddress 1.0.14
      __build_module enum34 1.0.4
      __build_module six 1.9.0
      __build_module pyasn1 0.1.8
      __build_module idna 2.0
      __build_module setuptools 18.0.1
    __build_module cryptography 1.0.1
  __build_module pyOpenSSL 0.15.1
}

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
  _build_lxml
  _build_modules
  _build_couchpotato
  _package
}
