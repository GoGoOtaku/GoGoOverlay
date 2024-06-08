# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="An improved modern version of Doom64EX"
HOMEPAGE="https://github.com/atsb/Doom64EX-Plus"
SRC_URI="https://github.com/atsb/Doom64EX-Plus/archive/refs/tags/4.0.0.0.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	media-libs/libpng
	media-libs/libsdl2[sound]
	media-libs/libsdl3[sound,video]
	media-libs/sdl3-net
	media-sound/fluidsynth
	virtual/glu
	virtual/opengl

"
RDEPEND="${DEPEND}"
BDEPEND=""

PATCHES=(
	${FILESDIR}/${P}-crushfix.patch
	${FILESDIR}/${P}-statsfix.patch
	${FILESDIR}/${P}-linux.patch
	${FILESDIR}/${PN}-sound.patch
)

DATADIR="/usr/share/doom64ex-plus"
CFLAGS="${CFLAGS} -DDOOM_UNIX_INSTALL=1 -DDOOM_UNIX_SYSTEM_DATADIR=\\\"${DATADIR}\\\""

src_install() {
	dobin DOOM64EX-Plus
	doman doom64ex-plus.6
	dodoc README.md AUTHORS

	insinto ${DATADIR}
	doins doom64ex-plus.wad doomsnd.sf2
	doins -r modding/DeHackED64

	insinto /usr/share/applications
	doins doom64ex-plus.desktop
}

