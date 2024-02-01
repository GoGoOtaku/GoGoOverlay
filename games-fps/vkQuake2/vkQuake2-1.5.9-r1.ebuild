# Copyright 1999-2022 Ophelia Beatrice de Sica
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit flag-o-matic

DESCRIPTION="id Software's Quake 2 v3.21 with mission packs and Vulkan support"
HOMEPAGE="https://github.com/kondrak/vkQuake2"

if [[ ${PV} = "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/kondrak/vkQuake2.git"
else
	SRC_URI="https://github.com/kondrak/vkQuake2/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
fi

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug"

BDEPEND="virtual/pkgconfig"
DEPEND="
	media-libs/alsa-lib
	media-libs/libglvnd
	media-libs/mesa[vulkan]
	media-libs/vulkan-loader[layers]
	virtual/glu
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXxf86dga
	x11-libs/libXxf86vm
	x11-libs/libxcb"

RDEPEND="${DEPEND}"

src_prepare() {
	eapply "${FILESDIR}/${P}-vkref_include_cstdio.patch"
	S="${S}/linux"
	eapply_user
}

src_compile() {
	btype="release"
	if use debug; then
		btype="debug"
	fi

	emake $btype
}

src_install() {
	dobin "${FILESDIR}/vkq2-link"

	btype="release"
	if use debug; then
		btype="debug"
	fi

	# Note: Files are installed with doexe to preserve folder structure.
	# dobin/dolib.so would cause files to be placed into a bin/lib64 subfolder.
	# Due to how quake2 loads game specific code at runtime
	# it is important to maintain this folder structure.
	cd "${btype}x64-glibc"
	exeinto "/usr/share/vkquake2"
	doexe q2ded
	doexe quake2
	doexe ref_glx.so
	doexe ref_vk.so

	exeinto "/usr/share/vkquake2/baseq2"
	doexe baseq2/gamex64.so

	exeinto "/usr/share/vkquake2/ctf"
	doexe ctf/gamex64.so

	exeinto "/usr/share/vkquake2/rogue"
	doexe rogue/gamex64.so

	exeinto "/usr/share/vkquake2/xatrix"
	doexe xatrix/gamex64.so

	exeinto "/usr/share/vkquake2/zaero"
	doexe zaero/gamex64.so
}

pkg_postinst() {
	elog "Run vkq2-link in your game directory"
	elog "or copy game files to /usr/share/vkquake2 (not recommended)"
	elog "The way Quake II loads game files sadly forces a rigorous folder structure"
	elog ""
	elog "This package does not come with any game files. (.pak files)"
	elog "Besides the main game vkQuake2 currently supports:"
	elog "* Quake II Mission Pack: The Reckoning (+set game xatrix)"
	elog "* Quake II Mission Pack: Ground Zero (+set game rogue)"
	elog "* Capture the Flag (Multiplayer) (+set game ctf)"
	elog "* Quake II: Zaero (free on moddb) (+set game zaero)"
}

