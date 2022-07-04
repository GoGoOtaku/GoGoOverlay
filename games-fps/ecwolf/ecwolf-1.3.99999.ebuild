# Copyright 1999-2020 Ophelia Beatrice de Sica
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake git-r3

DESCRIPTION="ECWolf is a port of the Wolfenstein 3D engine based of Wolf4SDL."
HOMEPAGE="https://maniacsvault.net/ecwolf/"
EGIT_REPO_URI="https://bitbucket.org/ecwolf/${PN}.git"

if [[ ${PV} != "9999" ]] ; then
	KEYWORDS="amd64 x86"
	# 2022-04-11
	EGIT_COMMIT="777265eccd1b6436ed4381b4b25e22f6c4365136"
fi

LICENSE="BSD GPL-2+ MIT non-free? ( XMAME )"
SLOT="0"
IUSE="non-free"

RDEPEND="
	media-libs/libsdl[opengl]
	media-libs/sdl-mixer
	media-libs/sdl-net
	sys-libs/zlib
	app-arch/bzip2
	media-libs/libjpeg-turbo
	x11-libs/gtk+
	app-arch/xz-utils"
DEPEND="${RDEPEND}"
BDEPEND=""


src_prepare() {
	default

	# Install binary to bin directory instead of /usr/games
	local DIRLINE="set(CMAKE_INSTALL_BINDIR \"games\")"
	set -- env \
	sed -i \
		-e "/${DIRLINE}/d" \
		CMakeLists.txt
	echo "$@"
	"$@" || die

	# We're not building debian packages today
	# this also fixes the docdir
	local CPACKLINE="set(USE_CPACK ON)"
	set -- env \
	sed -i \
		-e "/${CPACKLINE}/d" \
		CMakeLists.txt
	echo "$@"
	"$@" || die

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DGPL="$(usex non-free 0 1)"
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
}

pkg_postinst() {
	xdg_icon_cache_update

	echo
	ewarn "The original game data files are required for operation."
	elog "Consult the man page for more information."
	echo
}

