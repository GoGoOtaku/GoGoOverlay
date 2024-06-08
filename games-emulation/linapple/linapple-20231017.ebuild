# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

if [[ ${PV} == "20231017" ]] ; then
	PHASH="eb1f22e6093bc95cc93756fb905180d01c28656b"
fi

DESCRIPTION="Apple 2e emulator"
HOMEPAGE="https://github.com/linappleii/linapple"
SRC_URI="https://github.com/linappleii/linapple/archive/${PHASH}.zip -> ${P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-libs/libzip
	media-libs/libsdl
	media-libs/sdl-image
	net-misc/curl
	sys-libs/zlib
	x11-libs/libX11
"
RDEPEND="${DEPEND}"
BDEPEND=""

S=${WORKDIR}/linapple-${PHASH}

src_install() {
	emake DESTDIR="${D}" BINDIR="/usr/bin" DATADIR="/usr/share/linapple" install

	einstalldocs
}

