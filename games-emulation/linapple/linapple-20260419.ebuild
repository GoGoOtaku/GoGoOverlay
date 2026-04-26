# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

if [[ ${PV} == "20260419" ]] ; then
	PHASH="b7a26b46773996130a602b9ac7ac2ebeae5c0b11"
fi

DESCRIPTION="Apple 2e emulator"
HOMEPAGE="https://github.com/linappleii/linapple"
SRC_URI="https://github.com/linappleii/linapple/archive/${PHASH}.tar.gz -> ${P}.tar.gz"

S=${WORKDIR}/linapple-${PHASH}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-libs/libzip
	media-libs/libsdl
	media-libs/sdl-image
	net-misc/curl
	virtual/zlib
	x11-libs/libX11
"
RDEPEND="${DEPEND}"

src_install() {
	dobin "${S}/build/bin/linapple"

	insinto "/usr/share/linapple"
	doins "${S}/build/share/linapple/Master.dsk"
	doins "${S}/build/bin/APPLE2E.SYM"
	doins "${S}/build/bin/A2_BASIC.SYM"

	insinto "/etc/linapple"
	doins "${S}/build/etc/linapple/linapple.conf"

	einstalldocs
}
