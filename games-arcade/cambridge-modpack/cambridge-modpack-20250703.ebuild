# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

if [[ "${PV}" -eq "20250703" ]]; then
	PH="2bd35f47e190978272d6ab32829f6fd00e9b0807"
fi

DESCRIPTION="Officially-curated custom content for Cambridge"
HOMEPAGE="https://t-sp.in/cambridge/"
SRC_URI="https://github.com/cambridge-stacker/cambridge-modpack/archive/${PH}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/cambridge-modpack-${PH}"

# Project is hosted on Github and thus rights granted by the Github EULA apply
LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="games-arcade/cambridge"
RDEPEND="${DEPEND}"

src_install() {
	insinto /usr/share/cambridge
	doins -r res
	doins -r tetris
	doins -r skins
}
