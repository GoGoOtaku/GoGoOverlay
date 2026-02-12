# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

PVU="${PV^^}"

DESCRIPTION="A Doom 3 GPL source modification."
HOMEPAGE="https://github.com/dhewm/dhewm3"
SRC_URI="https://github.com/dhewm/dhewm3/archive/refs/tags/${PVU}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${PVU}"

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
BDEPEND="app-arch/unzip"

CMAKE_USE_DIR="${S}/neo"

DATADIR=/usr/share/dhewm3
DOCS="${S}/README.md"

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
	elog "Wide screen GUI mod also available at:"
	elog "https://github.com/dhewm/dhewm3/releases/tag/${PVU}"
	elog "To install extract into ~/.local/share/dhewm3."
	elog "(merge sub folders e.g. base into base etc)"
	elog "NOTE: GUI Mod is not under the GPL-3."
}
