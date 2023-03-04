# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="AppImage release of JRomManager"
HOMEPAGE="https://github.com/optyfr/JRomManager"
SRC_URI="https://github.com/optyfr/JRomManager/releases/download/${PV}/JRomManager-${PV}-x86_64.AppImage"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="strip"

DEPEND="sys-fs/fuse"
RDEPEND="${DEPEND} !games-emulation/jrommanager"
BDEPEND=""

S=${WORKDIR}

src_prepare() {
	cp "${DISTDIR}/JRomManager-${PV}-x86_64.AppImage" "${WORKDIR}/jrommanager"
	eapply_user
}

src_install() {
	dobin jrommanager
}

