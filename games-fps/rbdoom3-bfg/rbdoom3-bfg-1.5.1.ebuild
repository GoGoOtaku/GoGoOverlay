# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Doom 3 BFG Edition with modern engine features"
HOMEPAGE="https://www.moddb.com/mods/rbdoom-3-bfg"

NVRHI_HASH="1cbc9e9d16f997948c429739b1a1886fb4d0c796"
CXXOPTS_HASH="302302b30839505703d37fb82f536c53cf9172fa"
VULKAN_HASH="0193e158bc9f4d17e3c3a61c9311a0439ed5572d"

SRC_URI="
	https://github.com/RobertBeckebans/RBDOOM-3-BFG/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/RobertBeckebans/nvrhi/archive/${NVRHI_HASH}.tar.gz -> ${P}-nvrhi.tar.gz
	https://github.com/jarro2783/cxxopts/archive/${CXXOPTS_HASH}.tar.gz -> ${P}-cxxopts.tar.gz
	https://github.com/KhronosGroup/Vulkan-Headers/archive/${VULKAN_HASH}.tar.gz -> ${P}-vulkan.tar.gz
"

S=${WORKDIR}/RBDOOM-3-BFG-${PV}/neo

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
	!system-rapidjson? ( MIT )
"
SLOT="0"
KEYWORDS="~amd64"
IUSE="standalone classic +ffmpeg binkdec +system-zlib +system-libpng +system-libjpeg +system-rapidjson"
REQUIRED_USE="
	?? ( ffmpeg binkdec )
	standalone? ( !classic )
"

DEPEND="
	dev-util/glslang
	dev-util/vulkan-headers
	media-libs/libsdl2
	media-libs/openal

	ffmpeg? ( media-video/ffmpeg )

	system-libjpeg? ( media-libs/libjpeg-turbo )
	system-libpng? ( media-libs/libpng )
	system-rapidjson? ( dev-libs/rapidjson )
	system-zlib? ( sys-libs/zlib )

	dev-util/DirectXShaderCompiler
"
RDEPEND="${DEPEND}"

CMAKE_BUILD_TYPE=Release

PATCHES=(
	# Backport of Vulkan Swapchain fix
	"${FILESDIR}/${P}-nvrhi-vulkan-swapchain-backport.patch"

	# Backport of HLSL ternary fix
	"${FILESDIR}/${P}-ternary.patch"

	"${FILESDIR}/${P}-idlib.patch"
)

src_unpack() {
	unpack ${P}.tar.gz

	rmdir "${S}/extern/nvrhi"
	unpack ${P}-nvrhi.tar.gz
	mv nvrhi-${NVRHI_HASH} "${S}/extern/nvrhi"

	rmdir "${S}/extern/nvrhi/thirdparty/cxxopts"
	unpack ${P}-cxxopts.tar.gz
	mv cxxopts-${CXXOPTS_HASH} "${S}/extern/nvrhi/thirdparty/cxxopts"

	# RBDoom3BFG requires specific header version
	# otherwise it exits with an assert failure
	# This could probably be circumvented somewhere in NVRHI
	# but this would be too much for the scope of this ebuild
	rmdir "${S}/extern/nvrhi/thirdparty/Vulkan-Headers"
	unpack ${P}-vulkan.tar.gz
	mv Vulkan-Headers-${VULKAN_HASH} "${S}/extern/nvrhi/thirdparty/Vulkan-Headers"
}

src_configure() {
	mycmakeargs=(
		-Wno-dev
		# Keep rpath clean
		-DCMAKE_SKIP_RPATH=ON
		# In it's current state PCH is incompatible with march and mtune
		-DUSE_PRECOMPILED_HEADERS=OFF
		-DOPENAL=ON
		-DFFMPEG=$(usex ffmpeg)
		-DBINKDEC=$(usex binkdec)
		-DUSE_VULKAN=ON
		# What's a windows?
		-DWINDOWS10=OFF
		-DUSE_DX12=OFF

		-DSTANDALONE=$(usex standalone)
		-DDOOM_CLASSIC=$(usex classic)

		-DUSE_SYSTEM_ZLIB=$(usex system-zlib)
		-DUSE_SYSTEM_LIBPNG=$(usex system-libpng)
		-DUSE_SYSTEM_LIBJPEG=$(usex system-libjpeg)
		-DUSE_SYSTEM_RAPIDJSON=$(usex system-rapidjson)
	)

	cmake_src_configure
}

# CMakeList.txt does not declare installation targets so we install manually
src_install() {
	dobin "${BUILD_DIR}/RBDoom3BFG"
	dolib.so "${BUILD_DIR}/idlib/libidlib.so"
	dodoc -r "${S}/../docs/"
	insinto "/usr/share/rbdoom3bfg"
	doins -r "${S}/../base"
}
