# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake-multilib

if [[ ${PV} == "20241102" ]] ; then
	PHASH="9d76627ca50cddde3259dc06df180427730a1420"
fi

DESCRIPTION="A simple, cross-platform wrapper over TCP/IP sockets"
HOMEPAGE="https://libsdl.org/"
SRC_URI="https://github.com/libsdl-org/SDL_net/archive/${PHASH}.zip -> ${P}.zip"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS=""

DEPEND=">=media-libs/libsdl3-3.1.3[${MULTILIB_USEDEP}]"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/SDL_net-${PHASH}"

multilib_src_configure() {
	local mycmakeargs=(
		SDL3NET_SAMPLES=OFF
	)

	cmake_src_configure
}
