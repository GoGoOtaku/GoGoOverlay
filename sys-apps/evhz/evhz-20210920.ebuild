# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PHASH="35b7526e0655522bbdf92f6384f4e9dff74f38a0"

DESCRIPTION="Show mouse refresh rate under linux + evdev"
HOMEPAGE="https://git.sr.ht/~iank/evhz"
SRC_URI="https://git.sr.ht/~iank/evhz/archive/${PHASH}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0 GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	virtual/libc
"
RDEPEND="${DEPEND}"
BDEPEND="
	sys-kernel/linux-headers
"

S="${WORKDIR}/evhz-${PHASH}"

src_compile() {
	cc evhz.c -o evhz
}

src_install() {
	dosbin evhz
}

