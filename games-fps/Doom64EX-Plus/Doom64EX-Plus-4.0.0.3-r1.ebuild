# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop

DESCRIPTION="An improved modern version of Doom64EX"
HOMEPAGE="https://github.com/atsb/Doom64EX-Plus"
SRC_URI="https://github.com/atsb/Doom64EX-Plus/archive/refs/tags/${PV}.SDL.3.1.3.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${P}.SDL.3.1.3/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="man doc"

# Note: Technically media-libs/libsdl2[sound] is also required due to fluidsynth
# Note: Required sdl3-net is not finalized and so needs to be pegged to unstable
# Note: Removed audio/video use flags for libsdl3 since gentoo does not have them
DEPEND="
	>=media-libs/libsdl3-3.1.3
	~media-libs/sdl3-net-20241102
	media-libs/libpng
	media-sound/fluidsynth[sdl]
	virtual/glu
	virtual/opengl
"
RDEPEND="${DEPEND}"

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

	domenu doom64ex-plus.desktop
}
