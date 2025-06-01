# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic unpacker

DESCRIPTION="Doom 3 BFG Edition with modern engine features"
HOMEPAGE="https://www.moddb.com/mods/rbdoom-3-bfg"

NVRHI_HASH="fc4cfe69b9f65c7a0ba6509a52303efaba0a0e8c"
VULKAN_HASH="39f924b810e561fd86b2558b6711ca68d4363f68"
RTXMU_HASH="0c9ce1177000d5923e2cc6a35ae9cb7ff03748d2"
SHADERMAKE_HASH="13867771f6142f35690a5e2103c1e1efdd90cb0e"
BAKED_FILE="RBDOOM-3-BFG-1.6.0.22-full-win64-20250510-git-ba39ba6.7z"

SRC_URI="
	https://github.com/RobertBeckebans/RBDOOM-3-BFG/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/RobertBeckebans/nvrhi/archive/${NVRHI_HASH}.tar.gz -> ${P}-nvrhi.tar.gz
	https://github.com/KhronosGroup/Vulkan-Headers/archive/${VULKAN_HASH}.tar.gz -> ${P}-vulkan.tar.gz
	https://github.com/NVIDIA-RTX/RTXMU/archive/${RTXMU_HASH}.tar.gz -> ${P}-rtxmu.tar.gz
	https://github.com/RobertBeckebans/ShaderMake/archive/${SHADERMAKE_HASH}.tar.gz -> ${P}-shadermake.tar.gz
	https://github.com/RobertBeckebans/RBDOOM-3-BFG/releases/download/v${PV}/${BAKED_FILE} -> ${P}-baked.7z
"

S=${WORKDIR}/RBDOOM-3-BFG-${PV}/neo
BAKEDDIR="${WORKDIR}/prebuild"

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
	!ffmpeg? ( LGPL-2.1+ )
	!system-zlib? ( ZLIB )
	!system-rapidjson? ( MIT )
"
SLOT="0"
KEYWORDS="~amd64"
IUSE="standalone classic +rbdmap shadermake +ffmpeg +system-zlib +system-rapidjson pch +prebaked"
REQUIRED_USE="
	standalone? ( !classic )
"

DEPEND="
	dev-util/glslang
	media-libs/libsdl2
	media-libs/openal

	ffmpeg? ( media-video/ffmpeg )

	system-rapidjson? ( dev-libs/rapidjson )
	system-zlib? ( sys-libs/zlib )

	dev-util/DirectXShaderCompiler
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-lang/ispc
	dev-util/vulkan-headers
	app-arch/7zip
"

# Does not support RelWithDebInfo
CMAKE_BUILD_TYPE=Release

PATCHES=(
	# Fix for symbols Sys_Microseconds and Sys_CPUCount
	"${FILESDIR}/${P}-rbdmap.patch"

	# Since we install into the system directory
	# we also need to add the system directory to the search paths
	"${FILESDIR}/${PN}-add_systempaths.patch"

	"${FILESDIR}/${P}-fixes.patch"
)

src_unpack() {
	unpack ${P}.tar.gz

	rmdir "${S}/extern/nvrhi"
	unpack ${P}-nvrhi.tar.gz
	mv nvrhi-${NVRHI_HASH} "${S}/extern/nvrhi"

	rmdir "${S}/extern/ShaderMake"
	unpack ${P}-shadermake.tar.gz
	mv ShaderMake-${SHADERMAKE_HASH} "${S}/extern/ShaderMake"

	rmdir "${S}/extern/nvrhi/rtxmu"
	unpack ${P}-rtxmu.tar.gz
	mv RTXMU-${RTXMU_HASH} "${S}/extern/nvrhi/rtxmu"

	# RBDoom3BFG requires specific header version
	# otherwise it exits with an assert failure
	# This could probably be circumvented somewhere in NVRHI
	# but this would be too much for the scope of this ebuild
	# Quote from CMakeLists.txt:
	# > RB: moved this above the general Vulkan part
	# > so glslang does not include Vulkan SDK headers
	# > which causes all kinds of weird segmentation faults
	# > because struct sizes don't match
	rmdir "${S}/extern/nvrhi/thirdparty/Vulkan-Headers"
	unpack ${P}-vulkan.tar.gz
	mv Vulkan-Headers-${VULKAN_HASH} "${S}/extern/nvrhi/thirdparty/Vulkan-Headers"

	if use prebaked; then
		mkdir ${BAKEDDIR}
		pushd ${BAKEDDIR}
		unpack_7z ${P}-baked.7z
		popd
	fi
}

src_configure() {
	# Tools like ninja no longer add NDEBUG which affects asserts
	append-cflags "-DNDEBUG=1"
	append-cxxflags "-DNDEBUG=1"

	mycmakeargs=(
		-Wno-dev
		# Keep rpath clean
		-DCMAKE_SKIP_RPATH=ON
		-DOPENAL=ON
		-DUSE_VULKAN=ON
		-DUSE_PRECOMPILED_HEADERS=$(usex pch)
		-DFFMPEG=$(usex ffmpeg)
		-DBINKDEC=$(usex ffmpeg 0 1)
		# What's a windows?
		-DWINDOWS10=OFF
		-DUSE_DX12=OFF

		-DSTANDALONE=$(usex standalone)
		-DDOOM_CLASSIC=$(usex classic)

		-DUSE_SYSTEM_ZLIB=$(usex system-zlib)
		-DUSE_SYSTEM_RAPIDJSON=$(usex system-rapidjson)
	)

	cmake_src_configure
}

# CMakeList.txt does not declare installation targets
# for relevant files so we need to install manually
src_install() {
	dobin "${BUILD_DIR}/RBDoom3BFG"

	if use rbdmap; then
		dobin "${BUILD_DIR}/tools/compilers/rbdmap"
	fi

	# Not recommended
	if use shadermake; then
		dobin "${S}/bin/Release/ShaderMake"
	fi

	dolib.so "${BUILD_DIR}/idlib/libidlib.so"
	# Note: This library name might be too generic and could cause conflicts
	# If so contact me and I will make a small patch to rename it
	# or alternatively static link it
	dolib.so "${BUILD_DIR}/libs/moc/libMaskedOcclusionCulling.so"

	dodoc -r "${S}/../docs/"
	insinto "/usr/share/rbdoom3bfg"
	doins -r "${S}/../base"

	if use prebaked; then
		insinto "/usr/share/rbdoom3bfg/base"
		doins "${BAKEDDIR}/base/_rbdoom_blood.pk4"
		doins "${BAKEDDIR}/base/_rbdoom_core.pk4"
		doins "${BAKEDDIR}/base/_rbdoom_global_illumination_data.pk4"
	fi
}

pkg_postinst() {
	if use pch; then
		einfo "In it's current state PCH is not fully compatible with march and mtune"
	fi

	if !use prebaked; then
		ewarn "Not using prebaked content! This is NOT recommended!"
	fi

	einfo "If upgrading please remember to clean your user files."
	einfo "Starting with this ebuild RBDoom3BFG will look for files in /usr/share so copying files is no longer nessisary"
}
