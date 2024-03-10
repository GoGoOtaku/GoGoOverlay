# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PSHA="b5e5a829895ac98ccfe4629fbfbd8b819262bd00"

DESCRIPTION="Maintenance tools for overlay-filesystem"
HOMEPAGE="https://github.com/kmxz/overlayfs-tools"
SRC_URI="https://github.com/whole-tale/overlayfs-tools/archive/${PSHA}.zip -> ${P}.zip"

LICENSE="WTFPL-2"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}/${PN}-${PSHA}"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
	dosbin overlay
}

