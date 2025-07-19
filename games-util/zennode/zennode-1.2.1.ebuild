# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A DOOM node/blockmap/reject builder"
HOMEPAGE="https://www.mrousseau.org/programs/ZenNode/"
SRC_URI="https://www.mrousseau.org/programs/ZenNode/archives/${P}.zip"

S="${WORKDIR}/src/ZenNode"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="app-arch/unzip"

src_unpack() {
	unpack "${P}.zip"
	mv "${WORKDIR}/ZenNode-${PV}/zennode-src.zip" "${WORKDIR}"
	unpack "${WORKDIR}/zennode-src.zip"
	rm -rf "${WORKDIR}/ZenNode-${PV}"
}

src_install() {
	dobin "${S}/ZenNode"

	newbin "${S}/bspinfo ZenNodeBSPInfo"
	newbin "${S}/bspdiff ZenNodeBSPDiff"
	newbin "${S}/compare ZenNodeCompare"
}
