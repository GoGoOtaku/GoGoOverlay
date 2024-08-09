# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="An improved modern version of Doom64EX"
HOMEPAGE="https://github.com/atsb/Doom64EX-Plus"
SRC_URI="https://github.com/atsb/Doom64EX-Plus/archive/refs/tags/4.0.0.1.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

IUSE="man doc"

# Note: Technically media-libs/libsdl2[sound] is also required due to fluidsynth
DEPEND="
	=media-libs/libsdl3-20240501[sound,video]
	=media-libs/sdl3-net-20240508
	media-libs/libpng
	media-sound/fluidsynth[sdl]
	virtual/glu
	virtual/opengl
"
RDEPEND="${DEPEND}"
BDEPEND=""

PATCHES=(
	# Fixed in upstream
	${FILESDIR}/${P}-soundfix.patch
)

DATADIR="/usr/share/doom64ex-plus"
CFLAGS="${CFLAGS} -DDOOM_UNIX_INSTALL=1 -DDOOM_UNIX_SYSTEM_DATADIR=\\\"${DATADIR}\\\""

src_install() {
	# Lowercase to keep with man page
	newbin DOOM64EX-Plus doom64ex-plus

	if use man ; then
		doman doom64ex-plus.6
	fi

	if use doc ; then
		dodoc README.md AUTHORS
	fi

	insinto ${DATADIR}
	doins doom64ex-plus.wad doomsnd.sf2
	doins -r modding/DeHackED64

	insinto /usr/share/applications
	doins doom64ex-plus.desktop
}

