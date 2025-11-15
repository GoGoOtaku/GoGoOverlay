# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

if [ "${PV}" == "20251001" ]; then
	PHASH="c0cb594c3e62ab8b62b8fe8602e8269a9702ba27"
fi

inherit cmake

DESCRIPTION="Argonaut Blazing Render 3D engine (Dethrace Fork)"
HOMEPAGE="https://github.com/dethrace-labs/BRender-v1.3.2"
SRC_URI="https://github.com/dethrace-labs/BRender-v1.3.2/archive/${PHASH}.tar.gz -> ${P}.tar.gz"

S=${WORKDIR}/BRender-v1.3.2-${PHASH}

LICENSE="MIT"
SLOT="1.3.2"
KEYWORDS="~amd64"
IUSE="+drivers asan"

DEPEND="
	dev-lang/perl
	media-libs/libsdl2
	virtual/opengl
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${P}-fix_pretok_h.patch"
	"${FILESDIR}/tools.patch"
)

src_configure() {
	local mycmakeargs=(
		-DBRENDER_ASAN_ENABLED=$(usex asan ON OFF)
		-DBRENDER_BUILD_DRIVERS=$(usex drivers ON OFF)
		-DBRENDER_BUILD_EXAMPLES=OFF
		-DBRENDER_BUILD_TOOLS=OFF
		-DBRENDER_INSTALL=ON
		-DCMAKE_INSTALL_INCLUDEDIR="include/BRender-${SLOT}"
		-DCMAKE_INSTALL_LIBDIR="$(get_libdir)/BRender-${SLOT}"
		-DCMAKE_POSITION_INDEPENDENT_CODE=ON
	)

	cmake_src_configure
}
