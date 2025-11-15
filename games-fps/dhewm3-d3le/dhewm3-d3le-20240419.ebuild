# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

D3LE_HASH="0e6e3519b21eae4690810180210cc90b0174dc3d"

DESCRIPTION="Port of The Lost Missions to dhewm3"
HOMEPAGE="https://github.com/dhewm/dhewm3-sdk"
SRC_URI="https://github.com/dhewm/dhewm3-sdk/archive/${D3LE_HASH}.tar.gz -> ${P}-d3le.tar.gz"

S="${WORKDIR}/dhewm3-sdk-${D3LE_HASH}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	media-libs/libjpeg-turbo
	media-libs/libogg
	media-libs/libsdl2
	media-libs/libvorbis
	media-libs/openal
	net-misc/curl
	sys-libs/zlib:=
"
RDEPEND="${DEPEND}
	games-fps/dhewm3[d3xp]
"

DATADIR=/usr/share/dhewm3

src_configure() {
	mycmakeargs=(
		-DCMAKE_INSTALL_FULL_LIBDIR="/usr/$(get_libdir)"
	)

	cmake_src_configure
}

pkg_postinst() {
	elog "To play The Lost Missions mod you have to download the data files."
	elog "https://www.moddb.com/mods/the-lost-mission"
	elog "extract the files into a d3le subfolder inside your dhewm3 folder."
	elog "The BFG version of The Lost Missions is not compatbile with dhewm3!"
	elog "To play The Lost Missions you also need Resurrection of Evil installed."
	elog "Big thanks to Arl90 for porting The Lost Missions to classic Doom 3!"
	echo
}
