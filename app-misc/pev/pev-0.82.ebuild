# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="The PE file analysis toolkit"
HOMEPAGE="http://pev.sf.net"
SRC_URI="https://github.com/mentebinaria/readpe/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="amd64"
LICENSE="GPL-2 openssl"
SLOT="0"
IUSE=""

DEPEND="
	dev-libs/openssl
	dev-libs/libpe
"
RDEPEND="${DEPEND}"
S="${WORKDIR}/readpe-${PV}/src"

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

