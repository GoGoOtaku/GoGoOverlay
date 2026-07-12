# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake desktop

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
	"${FILESDIR}/harness.patch"
	"${FILESDIR}/fixes.patch"

	"${FILESDIR}/brender.patch"
	"${FILESDIR}/fix-install.patch"
	"${FILESDIR}/no-license.patch"
)

src_prepare() {
	cp "${FILESDIR}/brender.cmake" "${S}/lib/BRender-v1.3.2/CMakeLists.txt"

	if use debug; then
		CMAKE_BUILD_TYPE="Debug"
		export CMAKE_BUILD_TYPE
	fi

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
		-DDETHRACE_3DFX_PATCH=ON
		-DDETHRACE_SOUND_ENABLED=ON
		-DDETHRACE_NET_ENABLED=ON
		-DDETHRACE_PLATFORM_SDL1=ON
		-DDETHRACE_PLATFORM_SDL2=ON
		-DDETHRACE_PLATFORM_SDL3=ON
		-DBUILD_TESTS=$(usex test ON OFF)
		-DDETHRACE_ASAN=ON
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install

	newicon "${S}/packaging/icon_source.png" dethrace.png

	local entryargs=(
		dethrace
		Dethrace
		dethrace
		"Game;Action;Simulator"
		Comment="Reverse engineering the 1997 game \"Carmageddon\""
	)
	make_desktop_entry ${entryargs}

	insinto /usr/share/dethrace
	doins "${FILESDIR}/dethrace.ini"
}
