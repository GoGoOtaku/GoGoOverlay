# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A DOOM node/blockmap/reject builder"
HOMEPAGE="
	https://www.mrousseau.org/programs/ZenNode/
	https://github.com/Doom-Utils/zennode"
SRC_URI="https://github.com/Doom-Utils/zennode/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${P}/ZenNode"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="app-arch/unzip"

src_install() {
	dobin "${S}/ZenNode"

	newbin "${S}/bspinfo" ZenNodeBSPInfo
	newbin "${S}/bspdiff" ZenNodeBSPDiff
	newbin "${S}/compare" ZenNodeCompare
}
