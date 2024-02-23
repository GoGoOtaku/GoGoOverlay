# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="C++ bindings for SDL2"
HOMEPAGE="https://sdl2pp.amdmi3.ru"
SRC_URI="https://github.com/libSDL2pp/libSDL2pp/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64"
IUSE="image mixer ttf -static-libs"

DEPEND="
	media-libs/libsdl2
	image? ( media-libs/sdl2-image )
	mixer? ( media-libs/sdl2-mixer )
	ttf? ( media-libs/sdl2-ttf )
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
	local mycmakeargs=(
		-DSDL2PP_WITH_IMAGE=$(usex image ON OFF)
		-DSDL2PP_WITH_MIXER=$(usex mixer ON OFF)
		-DSDL2PP_WITH_TTF=$(usex ttf ON OFF)
		-DSDL2PP_STATIC=$(usex static-libs ON OFF)
		-DSDL2PP_CXXSTD=11
	)
	cmake_src_configure
}

