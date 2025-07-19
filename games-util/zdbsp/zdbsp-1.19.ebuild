# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="ZDBSP is ZDoom's internal node builder"
HOMEPAGE="https://github.com/rheit/zdbsp"
SRC_URI="https://github.com/rheit/zdbsp/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

PATCHES=(
	"${FILESDIR}/${P}-cmake-version.patch"
)

src_install() {
	dobin "${BUILD_DIR}/zdbsp"
}
