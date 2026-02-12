# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Source port for Blake Stone series"
HOMEPAGE="https://github.com/bibendovsky/bstone"
SRC_URI="https://github.com/bibendovsky/bstone/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz "

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="pch test"

RESTRICT="!test? ( test )"

DEPEND="media-libs/libsdl2"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DBSTONE_USE_PCH=$(usex pch ON OFF)
		-DBSTONE_USE_STATIC_LINKING=OFF
		-DBSTONE_USE_MULTI_PROCESS_COMPILATION=ON
		-DBSTONE_MORE_COMPILER_WARNINGS=ON
		-DBSTONE_TESTS=$(usex test ON OFF)
		-DBSTONE_TRIM_FILE_PATHS_IN_EXE=OFF
		-DBSTONE_INTERNAL_SDL2=OFF
	)

	cmake_src_configure
}

src_install() {
	# Upstream cmake does have install scripts but installs straight into
	# the prefix (e.g. /usr/ instead of /usr/bin/) but also installs doc files
	# into the same directory so that prefix can't just be set to /usr/bin.
	# This is easier than to rewrite the entire install script.
	dobin "${BUILD_DIR}/src/bstone/bstone"
}
