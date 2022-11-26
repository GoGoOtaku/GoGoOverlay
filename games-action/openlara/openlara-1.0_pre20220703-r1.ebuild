# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

SHA="c7e6e5f763b5632202d64f0b247bdad146a06a1e"

DESCRIPTION="Classic Tomb Raider open-source engine"
HOMEPAGE="xproger.info/projects/openlara/"
SRC_URI="https://github.com/XProger/OpenLara/archive/${SHA}.zip -> ${P}.zip"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+sdl log_fps debug"

DEPEND="
	virtual/opengl
	sdl? (
		media-libs/libsdl2 )
	!sdl? (
		media-libs/libpulse
		x11-libs/libX11 )
"
RDEPEND="${DEPEND}"
BDEPEND="!sdl? ( >=dev-util/premake-5 )"

S="${WORKDIR}/OpenLara-${SHA}"

src_prepare() {
	if !(use log_fps); then
		eapply "${FILESDIR}/${PN}-disable-fps-log.patch"
	fi

	if use sdl; then
		S=${S}/src/platform/sdl2
	else
		S=${S}/src/platform/nix
		cd ${S}
		premake5 gmake2
	fi

	eapply_user
}

src_compile() {
	local myemakeopts=()
	local mymaketarget=OpenLara
	local mymakeconfig=""
	if use sdl; then
		myemakeopts+=(
			LDFLAGS="${LDFLAGS} -lGL -lSDL2"
		)
		mymaketarget=openlara
	else
		if !(use debug); then
			mymakeconfig="config=release"
		fi
	fi

	emake $mymakeconfig $mymaketarget "${myemakeopts[@]}"
}

src_install() {
	if use sdl; then
		emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install
	else
		if use debug; then
			dobin bin/Debug/OpenLara
		else
			dobin bin/Release/OpenLara
		fi
	fi
}

pkg_postinst() {
	echo
	ewarn "The original game data files are required for operation."
	elog "audio/"
	elog "└── 1"
	elog "    └── {CD Audio Files as Ogg}"
	elog "level/"
	elog "└── 1"
	elog "    └── {CD /DATA Files}"
	elog "video/"
	elog "└── 1"
	elog "    └── {CD /FLV Files}"
	echo
}

