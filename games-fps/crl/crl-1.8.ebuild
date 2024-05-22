# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Playtesting focused Doom engine"
HOMEPAGE="https://jnechaevsky.github.io/crl/"
SRC_URI="https://github.com/JNechaevsky/CRL/archive/refs/tags/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

IUSE="+sdl2-mixer fluidsynth net lto asan"

DEPEND="
	>=dev-libs/miniz-2.0.0
	>=media-libs/libsdl2-2.0.18
	media-libs/libsamplerate

	sdl2-mixer? ( >=media-libs/sdl2-net-2.0.0 )
	fluidsynth? ( >=media-sound/fluidsynth-2.2.0 )
	net? ( >=media-libs/sdl2-mixer-2.0.2 )
"
RDEPEND="${DEPEND}"
BDEPEND=""

PATCHES=(
	${FILESDIR}/${P}-fix-sdl2-mixer-dep.patch
)

S=${WORKDIR}/CRL-${P}

src_configure() {
	local mycmakeargs=(
		-DENABLE_LTO=$(usex lto On Off)
		-DENABLE_ASAN=$(usex asan ON OFF)
		-DENABLE_SDL2_NET=$(usex net ON OFF)
		-DENABLE_SDL2_MIXER=$(usex sdl2-mixer ON OFF)
		-DHAVE_FLUIDSYNTH=$(usex fluidsynth ON OFF)
	)
	cmake_src_configure
}

src_install() {
	dobin ${BUILD_DIR}/src/crl-doom
	dobin ${BUILD_DIR}/src/crl-heretic
	dobin ${BUILD_DIR}/src/crl-setup
}

