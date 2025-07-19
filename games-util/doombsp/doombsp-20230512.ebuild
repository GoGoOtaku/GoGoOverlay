# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

if [[ ${PV} == "20230512" ]] ; then
	PHASH="01969e4508a40e69b735df3362da308a0abb3d96"
fi

DESCRIPTION="id Software's node builder for Doom, made cross-platform"
HOMEPAGE="https://github.com/teefoss/doombsp"
SRC_URI="https://github.com/teefoss/doombsp/archive/${PHASH}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${PHASH}"

LICENSE="DUL"
SLOT="0"
KEYWORDS="~amd64"

PATCHES=(
	"${FILESDIR}/doombsp.patch"
	"${FILESDIR}/link.patch"
)

src_install() {
	dobin doombsp
}
