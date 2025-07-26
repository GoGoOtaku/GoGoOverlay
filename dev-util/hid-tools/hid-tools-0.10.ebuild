# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{9..14} )
inherit distutils-r1

DESCRIPTION="Python scripts to manipulate HID data"
HOMEPAGE="https://gitlab.freedesktop.org/libevdev/hid-tools"
SRC_URI="https://gitlab.freedesktop.org/libevdev/hid-tools/-/archive/${PV}/${P}.tar.bz2"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-python/click
	dev-python/libevdev
	dev-python/parse
	dev-python/pyroute2
	dev-python/pyyaml
	dev-python/typing-extensions
"
RDEPEND="${DEPEND}"

distutils_enable_tests pytest
