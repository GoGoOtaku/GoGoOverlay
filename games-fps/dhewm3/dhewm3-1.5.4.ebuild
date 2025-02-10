# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="A Doom 3 GPL source modification."
HOMEPAGE="https://github.com/dhewm/dhewm3"
SRC_URI="https://github.com/dhewm/dhewm3/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+client +base +d3xp +dedicated +imgui"

DEPEND="
	media-libs/libjpeg-turbo
	media-libs/libogg
	media-libs/libsdl2
	media-libs/libvorbis
	media-libs/openal
	net-misc/curl
"
RDEPEND="${DEPEND}"

CMAKE_USE_DIR="${S}/neo"

DATADIR=/usr/share/dhewm3
DOCS="README.md"

src_configure() {
	local mycmakeargs=(
		-DCORE=$(usex client ON OFF)
		-DBASE=$(usex base ON OFF)
		-DD3XP=$(usex d3xp ON OFF)
		-DDEDICATED=$(usex dedicated ON OFF)
		-DIMGUI=$(usex imgui ON OFF)
		-DSDL2=ON
	)
	cmake_src_configure
}

pkg_postinst() {
	elog "You need to copy *.pk4 from either your CD or installation folder"
	elog "/usr/share/dhewm3/base before running the game."
	echo
	if ( use d3xp ) ; then
	elog "To play Resurrection of Evil you will need to install the .*pk4 files"
	elog "from the d3xp folder into a d3xp subfolder in your dhewm3."
	elog "The steam and gog release also come with Resurrection of Evil."
	echo
	fi
}
