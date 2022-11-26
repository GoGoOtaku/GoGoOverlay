# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="Catacomb source port with OpenGL graphics"
HOMEPAGE="https://github.com/ArnoAnsems/CatacombGL"
EGIT_REPO_URI="https://github.com/ArnoAnsems/CatacombGL.git"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS=""
IUSE="-test"

DEPEND="
	media-libs/libsdl2
	virtual/opengl
	virtual/glu
	test? ( dev-cpp/gtest )
"
RDEPEND="${DEPEND}"
BDEPEND="dev-util/cmake"

src_configure() {
	local mycmakeargs=()

	if use test ; then
		mycmakeargs+=( BUILD_TESTS=ON )
	fi

	cmake_src_configure
}

