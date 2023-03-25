# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

LIBRETRO_REPO_NAME="libretro/mame"
inherit git-r3 check-reqs libretro-core

DESCRIPTION="MAME (current) for libretro."
HOMEPAGE="https://github.com/libretro/mame"
KEYWORDS=""

LICENSE="MAME-GPL"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

CHECKREQS_MEMORY="8G" # Debug build requires more
CHECKREQS_DISK_BUILD="25G" # Debug build requires more

pkg_pretend() {
		einfo "Checking for sufficient disk space to build ${PN} with debugging CFLAGS"
		check-reqs_pkg_pretend
}

pkg_setup() {
		check-reqs_pkg_setup
}

src_compile() {
		myemakeargs=(
			PTR64=1
		)
		libretro-core_src_compile
}

