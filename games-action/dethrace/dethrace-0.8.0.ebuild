# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

if [[ ${PV} == "0.8.0" ]]; then
	BRENDER_HASH="9c34086300f4f0bbb3a55206380f25b17dad6c12"
fi

DESCRIPTION="Reverse engineered Carmageddon (1997)"
HOMEPAGE="https://github.com/dethrace-labs/dethrace"
SRC_URI="https://github.com/dethrace-labs/dethrace/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="bugs test debug"
RESTRICT="!test? ( test )"

DEPEND="media-libs/libsdl2"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/brender.patch"
	"${FILESDIR}/fix-install.patch"
	"${FILESDIR}/no-license.patch"
)

src_prepare() {
	cp "${FILESDIR}/brender.cmake" "${S}/lib/BRender-v1.3.2/CMakeLists.txt"

	eapply_user
	cmake_src_prepare
}

src_configure() {
	echo ${PV} > VERSION

	local mycmakeargs=(
		-DCMAKE_INSTALL_RPATH="/usr/$(get_libdir)/BRender-1.3.2"
		-DDETHRACE_INSTALL=ON
		-DDETHRACE_WERROR=ON
		-DDETHRACE_FIX_BUGS=$(usex bugs OFF ON)
		-DBUILD_TESTS=$(usex test ON OFF)
	)
	cmake_src_configure
}
