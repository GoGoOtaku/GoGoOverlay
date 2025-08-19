# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake-multilib

DESCRIPTION="Instrument file software library"
HOMEPAGE="https://github.com/swami/libinstpatch"
SRC_URI="https://github.com/swami/libinstpatch/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+shared debug"

DEPEND="
	>=dev-libs/glib-2.14
	>=media-libs/libsndfile-1.2.1
"
RDEPEND="${DEPEND}"

src_configure() {
	# Introspection is broken
	# See: https://github.com/swami/libinstpatch/issues/34
	# GTKDOC isn't broken but it calls the linker in a weird way that breaks
	# under some LDFLAGS like -Wl,O3 for link time optimization
	mycmakeargs=(
		-Denable-debug=$(usex debug ON OFF)
		-DGTKDOC_ENABLED=OFF
		-DINTROSPECTION_ENABLED=OFF
		-DBUILD_SHARED_LIBS=$(usex shared ON OFF)
	)
	cmake-multilib_src_configure
}
