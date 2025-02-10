# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A customizable, open-source falling block game."
HOMEPAGE="https://github.com/mmatyas/openblok"
SRC_URI="https://github.com/mmatyas/openblok/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+ OFL-1.1 VicFiegerLicense"
SLOT="0"
KEYWORDS="~amd64"
IUSE="flac jpeg mod mp3 test"
RESTRICT="!test? ( test )"

DEPEND="
	media-libs/libsdl2
	media-libs/sdl2-mixer[flac?,mod?,mp3?]
	media-libs/sdl2-image[jpeg?]
	media-libs/sdl2-ttf
	media-libs/libSDL2pp[mixer,image,ttf]
	test? ( dev-libs/unittest++ )
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-move_bin_directory.patch"
	"${FILESDIR}/${PN}-0.8.6-external_libs.patch"
	"${FILESDIR}/${PN}-0.8.6-fix_build_types.patch"
	"${FILESDIR}/${PN}-0.8.6-static_linking.patch"
)

src_configure() {
	local mycmakeargs=(
		-DENABLE_FLAC=$( usex flac ON OFF )
		-DENABLE_JPG=$( usex jpeg ON OFF )
		-DENABLE_MOD=$( usex mod ON OFF )
		-DENABLE_MP3=$( usex mp3 ON OFF )
		-DBUILD_TESTS=$( usex test ON OFF )
		-DBUILD_SHARED_LIBS=OFF
		-DUSE_SYSTEM_LIBSDL2PP=ON
		-DUSE_SYSTEM_UNITTESTCPP=ON
	)
	cmake_src_configure
}
