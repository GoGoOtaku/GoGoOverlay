# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

if [[ "${PV}" == "20251009" ]]; then
	PH="189e6c22a9acb01b6eea26659f6944e60f6cb3d8"
fi

DESCRIPTION="Show mouse refresh rate under linux + evdev"
HOMEPAGE="https://git.sr.ht/~iank/evhz"
SRC_URI="https://git.sr.ht/~iank/evhz/archive/${PH}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/evhz-${PH}"

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

src_compile() {
	cc evhz.c -o evhz
}

src_install() {
	dosbin evhz
}
