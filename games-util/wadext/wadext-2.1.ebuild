# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A simple WAD extraction command line tool for Doom-engine mods"
HOMEPAGE="https://github.com/ZDoom/wadext"
SRC_URI="https://github.com/ZDoom/wadext/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

src_install() {
	dobin "${S}_build/wadext"
}
