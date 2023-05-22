# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="The PE library used by pev"
HOMEPAGE="pev.sf.net"
SRC_URI="https://github.com/mentebinaria/readpe/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-libs/openssl"
RDEPEND="${DEPEND}"
BDEPEND=""

LDFLAGS="${LDFLAGS} -lm"

S="${WORKDIR}/readpe-${PV}/lib/libpe"

src_prepare() {
	default

	local MY_PREFIX=${EPREFIX}/usr
	local MY_LIBDIR=$(get_libdir)

	set -- env \
	sed -i -E \
		-e "/^prefix/ s#(.*=[[:space:]]*).*#\1${MY_PREFIX}#" \
		-e "/^libdir/ s#(.*=[[:space:]]*).*#\1\$(exec_prefix)/${MY_LIBDIR}#" \
		Makefile
	echo "$@"
	"$@" || die
}

src_install() {
	default

	cd include
	doheader -r libpe
}

