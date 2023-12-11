# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github/merces/pev"
	EGIT_SUBMODULES=( lib/libpe )
else
	KEYWORDS="~amd64 ~x86"
	EGIT_COMMIT_LIBPE="__TEMPLATE_LIBPE_SHA__"
	SRC_URI="https://github.com/merces/pev/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
		https://github.com/merces/libpe/archive/${EGIT_COMMIT_LIBPE}.tar.gz -> libpe-${EGIT_COMMIT_LIBPE}.tar.gz"
fi

DESCRIPTION="The PE file analysis toolkit"
HOMEPAGE="http://pev.sf.net"

LICENSE="Apache-2.0"
SLOT="0/${PVR}"
IUSE=""
RESTRICT="mirror"

DEPEND="dev-libs/openssl"
RDEPEND="${DEPEND}"

src_unpack() {
	default

	if [[ "${PV}" == "9999" ]]; then
		git-r3_src_unpack
	else
		unpack ${P}.tar.gz
		unpack libpe-${EGIT_COMMIT_LIBPE}.tar.gz
		set -- env \
		cp -rp libpe-${EGIT_COMMIT_LIBPE}/* ${P}/lib/libpe
		echo "$@"
		"$@" || die
    fi
}

src_prepare() {
	default

	local MY_PREFIX=${EPREFIX}/usr
	local MY_LIBDIR=$(get_libdir)

	set -- env \
	sed -i -E \
		-e "/^prefix/ s#(.*=[[:space:]]*).*#\1${MY_PREFIX}#" \
		-e "/^libdir/ s#(.*=[[:space:]]*).*#\1\$(exec_prefix)/${MY_LIBDIR}#" \
		lib/libpe/Makefile
	echo "$@"
	"$@" || die

	set -- env \
	sed -i -E \
		-e "/^prefix/ s#(.*=[[:space:]]*).*#\1${MY_PREFIX}#" \
		-e "/^libdir/ s#(.*=[[:space:]]*).*#\1\$(exec_prefix)/${MY_LIBDIR}#" \
		src/Makefile
	echo "$@"
	"$@" || die
}

