# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="The PE file analysis toolkit"
HOMEPAGE="http://pev.sf.net"

KEYWORDS="amd64"
LICENSE="GPL-2"
SLOT="0"

DEPEND="
	app-misc/readpe
"
RDEPEND="${DEPEND}"

pkg_postinst() {
	ewarn "app-misc/pev has been moved to app-misc/readpe!"
	ewarn "Please run \"emerge --noreplace app-misc/readpe\" to add readpe to the world file"
}

