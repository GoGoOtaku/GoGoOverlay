# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake desktop xdg

DESCRIPTION="Speedrunning focused fork of prboom+ with extra tooling for demos."
HOMEPAGE="https://github.com/kraflab/dsda-doom"
SRC_URI="https://github.com/kraflab/dsda-doom/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${P}/prboom2"

LICENSE="GPL-2+ GPL-3+ BSD BSD-2 BSD-with-disclosure CC-BY-3.0 CC0-1.0 LGPL-2.1+ MIT public-domain"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="fluidsynth mad portmidi sdl2-image vorbis"

DEPEND="
	dev-libs/libzip
	media-libs/libsdl2[opengl,joystick,sound,video]
	media-libs/sdl2-mixer[midi]
	sys-libs/zlib
	fluidsynth? ( media-sound/fluidsynth:= )
	mad? ( media-libs/libmad )
	portmidi? ( media-libs/portmidi )
	sdl2-image? ( media-libs/sdl2-image )
	vorbis? ( media-libs/libvorbis )"
RDEPEND="${DEPEND}"

src_prepare() {
	rm cmake/FindLibMad.cmake
	cp "${FILESDIR}/FindLibMad.cmake" cmake/
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DWITH_IMAGE="$(usex sdl2-image)"
		-DWITH_MAD="$(usex mad)"
		-DWITH_FLUIDSYNTH="$(usex fluidsynth)"
		-DWITH_VORBISFILE="$(usex vorbis)"
		-DWITH_PORTMIDI="$(usex portmidi)"
		-DDOOMWADDIR="${EPREFIX}/usr/share/doom"
		-DWAD_DATA_PATH="${EPREFIX}/usr/share/doom"
		-DDSDA_INSTALL_COPYRIGHT_DIR="${EPREFIX}/usr/share/doc/${P}"
	)
	cmake_src_configure
}

src_install() {
	doicon ICONS/${PN}.png
	domenu ICONS/${PN}.desktop
	cmake_src_install
}
