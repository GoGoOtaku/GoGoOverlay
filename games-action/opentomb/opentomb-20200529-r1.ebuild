# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

HASH="8e4c249c1cd76e3a9f1394670fb1130b4c7ef251"

DESCRIPTION="An open-source Tomb Raider 1-5 engine remake"
HOMEPAGE="http://opentomb.github.io/"
SRC_URI="https://github.com/opentomb/OpenTomb/archive/${HASH}.zip -> opentomb.zip"

# OpenTomb - LGPL-3
# Droid Sans Mono (Bundled) - Apache 2.0
# Roboto Condensed Regular (Bundled) - Apache 2.0
# Roboto Regular (Bundled) - Apache 2.0
# Bullet (Bundled) - ZLIB
# Lua (Bundled) - MIT
# FreeType2 (Bundled) - FTL GPL-2+
# OpenAL (Bundled - But only for MinGW) - LGPL-2+ BSD
LICENSE="LGPL-3 Apache-2.0 MIT ZLIB !system-freetype? ( FTL GPL-2+ )"
SLOT="0"
KEYWORDS="~amd64"
IUSE="system-freetype"

DEPEND="
	system-freetype? ( media-libs/freetype:2 )
	virtual/opengl
	media-libs/libpng
	media-libs/libsdl2
	media-libs/openal
	sys-libs/zlib"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/OpenTomb-${HASH}"

src_configure() {
	local mycmakeargs=(
		-DFORCE_SYSTEM_FREETYPE=$(usex system-freetype ON OFF )
	)
	cmake_src_configure
}

src_install() {
	dodir /usr/share/OpenTomb
	insinto /usr/share/OpenTomb

	doins config.lua
	doins -r scripts
	doins -r shaders
	doins -r resource

	cd "${WORKDIR}/OpenTomb-${HASH}_build"
	dobin OpenTomb
}

