# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Ports of Keen Dreams, the 3D Catacomb games and Wolfenstein 3D"
HOMEPAGE="https://github.com/ReflectionHLE/ReflectionHLE"
SRC_URI="https://github.com/ReflectionHLE/ReflectionHLE/archive/refs/tags/release-${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+ BSD ID-Wolf3D LGPL2.1+ MIT public-domain"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S=${WORKDIR}/ReflectionHLE-release-${PV}

