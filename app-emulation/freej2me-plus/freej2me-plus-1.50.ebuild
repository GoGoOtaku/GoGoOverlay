# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit java-pkg-2 xdg-utils desktop

DESCRIPTION="A free J2ME emulator with libretro, awt and sdl2 frontends"
HOMEPAGE="https://tasemulators.github.io/freej2me-plus"
SRC_URI="https://github.com/TASEmulators/freej2me-plus/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

# This is just 3-Clause BSD and GPL-3+ under the hood
LICENSE="GPL-3+-with-ObjectWeb-ASM-exception"
SLOT="0"
KEYWORDS="~amd64"
IUSE="libretro"

# This project uses tools.jar
DEPEND="
	virtual/jdk:1.8
"
RDEPEND="${DEPEND}"
BDEPEND="dev-java/ant"

JAVA_PKG_FORCE_VM="openjdk-bin-8"

src_prepare() {
	eapply "${FILESDIR}/plus.patch"
	eapply_user
}

src_compile() {
	eant

	if use libretro; then
		pushd "${S}/src/libretro"
		emake
		popd
	fi
}

src_install() {
	java-pkg_dojar "${S}/build/freej2meplus.jar"

	if use libretro; then
		java-pkg_dojar "${S}/build/freej2meplus-lr.jar"

		insinto "/usr/$(get_libdir)/libretro/"
		doins "${S}/src/libretro/freej2meplus_libretro.so"
		fperms 644 "/usr/$(get_libdir)/libretro/freej2meplus_libretro.so"

		insinto /usr/share/libretro/info
		newins "${S}/src/libretro/freej2me_libretro.info" "freej2meplus_libretro.info"
	fi

	make_desktop_entry "env JAVA_HOME=$(java-config --select-vm openjdk-bin-8 --jdk-home) java -jar /usr/share/freej2me-plus/lib/freej2meplus.jar" "FreeJ2ME-Plus" "freej2meplus" "Game"
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
