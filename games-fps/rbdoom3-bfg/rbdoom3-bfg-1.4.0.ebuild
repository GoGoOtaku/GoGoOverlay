# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Doom 3 BFG Edition with modern engine features"
HOMEPAGE="https://www.moddb.com/mods/rbdoom-3-bfg"
SRC_URI="https://github.com/RobertBeckebans/RBDOOM-3-BFG/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

# GPL-3			- Main Code
# BSD			- msinttypes, TinyEXR, OpenEXR
# BSD-1			- Mesa
# BSD-2 		- Base64, binpack2d, SSAO, SSGI
# CC0-1.0		- Replacement Textures
# MIT			- ImGui, stb
# RSA			- MD4
# ZLIB  		- Minizip, CRC32i irrxml, mikktspace
# public-domain - MD5, stb
# GPL-2			- timidity
# LGPL-2		- timidity
# Artistic		- timidity
LICENSE="
	GPL-3 BSD BSD-1 BSD-2 CC0-1.0 MIT RSA ZLIB public-domain
	|| ( GPL-2 LGPL-2 Artistic )
	binkdec? ( LGPL-2.1+ )
	!system-libjpeg? ( BSD IJG ZLIB )
	!system-zlib? ( ZLIB )
	!system-libpng? ( libpng2 )
	!system-libglew? ( BSD MIT )
	!system-rapidjson? ( MIT )
"
SLOT="0"
KEYWORDS="~amd64"
IUSE="standalone classic +sdl2 +ffmpeg binkdec vulkan +system-zlib +system-libpng +system-libjpeg +system-libglew +system-rapidjson"
REQUIRED_USE="
	?? ( ffmpeg binkdec )
	vulkan? ( sdl2 )
	standalone? ( !classic )
"

DEPEND="
	dev-util/glslang
	media-libs/openal

	!sdl2? ( media-libs/libsdl )
	sdl2? ( media-libs/libsdl2 )
	ffmpeg? ( media-video/ffmpeg )
	vulkan? ( dev-util/vulkan-headers )

	system-zlib? ( sys-libs/zlib )
	system-libpng? ( media-libs/libpng )
	system-libjpeg? ( media-libs/libjpeg-turbo )
	system-libglew? ( media-libs/glew )
	system-rapidjson? ( dev-libs/rapidjson )
"
RDEPEND="${DEPEND}"
BDEPEND=""

S=${WORKDIR}/RBDOOM-3-BFG-${PV}/neo
CMAKE_BUILD_TYPE=Release

PATCHES=(
	# Remove non C compliant code in Material.h - Fixed Upstream
	"${FILESDIR}"/${PN}-${PV}-fix-non-standard-C-typedef.patch

	# Remove JPEG_INTERNALS from Cinematic.cpp
	"${FILESDIR}"/${PN}-remove-jpeg-internals-in-renderer.patch
	# Fix bfgimgui include
	"${FILESDIR}"/${PN}-fix-bfgimgui-include.patch

	# Use system glslang; Makes installation easier
	"${FILESDIR}"/${PN}-system-glslang.patch
)

src_configure() {
	mycmakeargs=(
		-Wno-dev
		# Keep rpath clean
		-DCMAKE_SKIP_RPATH=ON
		# In it's current state PCH is incompatible with march and mtune
		-DUSE_PRECOMPILED_HEADERS=off

		-DOpenGL_GL_PREFERENCE=GLVND

		-DSDL2=$(usex sdl2)
		-DFFMPEG=$(usex ffmpeg)
		-DBINKDEC=$(usex binkdec)
		-DUSE_VULKAN=$(usex vulkan)
		# This does not work atm
		-DSPIRV_SHADERC=OFF

		-DUSE_SYSTEM_ZLIB=$(usex system-zlib)
		-DUSE_SYSTEM_LIBPNG=$(usex system-libpng)
		-DUSE_SYSTEM_LIBJPEG=$(usex system-libjpeg)
		-DUSE_SYSTEM_LIBGLEW=$(usex system-libglew)
		-DUSE_SYSTEM_RAPIDJSON=$(usex system-rapidjson)
	)

	if use vulkan; then
		ewarn "[Vulkan] Vulkan backend is unfinished in general"
		ewarn "[Vulkan] Shadow Mapping is not supported yet"
		ewarn "[Vulkan] HDR is not supported yet and GI looks bad"
		ewarn "[Vulkan] Post processing and SMAA is not supported yet"
	fi

	cmake_src_configure
}

# CMakeList.txt does not declare installation targets so we install manually
src_install() {
	dobin ${BUILD_DIR}/RBDoom3BFG
	dolib.so ${BUILD_DIR}/idlib/libidlib.so
	dodoc -r "$S/../docs/"
	insinto "/usr/share/RBDoom3BFG"
	doins -r "$S/../base"
}

