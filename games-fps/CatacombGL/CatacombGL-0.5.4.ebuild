# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Catacomb source port with OpenGL graphics"
HOMEPAGE="https://github.com/ArnoAnsems/CatacombGL"
SRC_URI="https://github.com/ArnoAnsems/CatacombGL/archive/refs/tags/v${PV}-beta.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="-test"

DEPEND="
	media-libs/libsdl2
	virtual/opengl
	virtual/glu
	test? ( dev-cpp/gtest )
"
RDEPEND="${DEPEND}"
BDEPEND="dev-util/cmake"

S="${WORKDIR}/${P}-beta"

src_configure() {
	local mycmakeargs=()

	if use test ; then
		mycmakeargs+=( BUILD_TESTS=ON )
	fi

	cmake_src_configure
}

