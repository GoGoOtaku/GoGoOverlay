# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake-multilib

if [[ ${PV} == "20240508" ]] ; then
	PHASH="8cacdeef36ffe89399bc85a2a59f25e1e4991e9f"
fi

DESCRIPTION="A simple, cross-platform wrapper over TCP/IP sockets"
HOMEPAGE="https://libsdl.org/"
SRC_URI="https://github.com/libsdl-org/SDL_net/archive/${PHASH}.zip -> ${P}.zip"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS=""

DEPEND=">=media-libs/libsdl3-3.1.2[${MULTILIB_USEDEP}]"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/SDL_net-${PHASH}"

multilib_src_configure() {
	local mycmakeargs=(
		SDL3NET_SAMPLES=OFF
	)

	cmake_src_configure
}
