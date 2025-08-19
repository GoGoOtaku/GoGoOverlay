# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake-multilib

if [[ ${PV} == "20250712" ]] ; then
	PHASH="15cc556f9db8a886faa6105b3fcf726583d45572"
fi

DESCRIPTION="A simple, cross-platform wrapper over TCP/IP sockets"
HOMEPAGE="https://libsdl.org/"
SRC_URI="https://github.com/libsdl-org/SDL_net/archive/${PHASH}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/SDL_net-${PHASH}"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS=""

DEPEND=">=media-libs/libsdl3-3.1.3[${MULTILIB_USEDEP}]"
RDEPEND="${DEPEND}"

multilib_src_configure() {
	local mycmakeargs=(
		SDL3NET_SAMPLES=OFF
	)

	cmake_src_configure
}
