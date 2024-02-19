# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools gnome2-utils

DESCRIPTION="GTK implementation of the board game Nine Men's Morris"
HOMEPAGE="http://www.nine-mens-morris.net/index.html"
SRC_URI="https://github.com/farindk/morris/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-libs/boost
	dev-libs/glib
	x11-libs/gtk+:2
	virtual/libintl
	virtual/pkgconfig
	x11-libs/gdk-pixbuf
"
RDEPEND="${DEPEND}"
BDEPEND="sys-devel/gettext"

src_prepare() {
	default

	# Remove problematic LDFLAGS declaration
	sed -i -e '/^LDFLAGS/d' src/Makefile.am || die

	# Rerun autotools
	eautoreconf
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}

