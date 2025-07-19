# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

if [[ ${PV} == "20240712" ]] ; then
	PHASH="22af6defeb84ce836e0b184d6be5e80f127d9451"
fi

DESCRIPTION=" A blockmap, reject and node builder for Doom, Heretic and Hexen"
HOMEPAGE="https://doom2.no/zokumbsp/ https://github.com/zokum-no/zokumbsp"
SRC_URI="https://github.com/zokum-no/zokumbsp/archive/${PHASH}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/zokumbsp-${PHASH}/src/zokumbsp"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"

src_install() {
	dobin "${S}/zokumbsp"
	dodoc "${WORKDIR}/zokumbsp-${PHASH}/doc/zokumbsp.txt"
	dodoc "${WORKDIR}/zokumbsp-${PHASH}/doc/changelog.txt"
}
