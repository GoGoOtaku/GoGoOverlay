# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

M_PV=$(ver_cut 1-3)
B_PV=$(ver_cut 1-3)"-"$(ver_cut 4).$(ver_cut 5)

DESCRIPTION="AppImage release of JRomManager"
HOMEPAGE="https://github.com/optyfr/JRomManager"
SRC_URI="https://github.com/optyfr/JRomManager/releases/download/${PV}/JRomManager-${PV}-x86_64.AppImage -> ${P}.AppImage"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="strip"

DEPEND="sys-fs/fuse"
RDEPEND="${DEPEND} !games-emulation/jrommanager"
BDEPEND=""

S=${WORKDIR}

src_prepare() {
	cp "${DISTDIR}/${P}.AppImage" "${WORKDIR}/jrommanager"
	eapply_user
}

src_install() {
	dobin jrommanager
}

