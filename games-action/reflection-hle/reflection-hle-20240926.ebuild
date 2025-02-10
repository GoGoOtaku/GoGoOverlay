# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Ports of Keen Dreams, the 3D Catacomb games and Wolfenstein 3D"
HOMEPAGE="https://github.com/ReflectionHLE/ReflectionHLE"
SRC_URI="https://github.com/ReflectionHLE/ReflectionHLE/archive/refs/tags/release-${PV}.tar.gz -> ${P}.tar.gz"

S=${WORKDIR}/ReflectionHLE-release-${PV}

LICENSE="GPL-2+ BSD ID-Wolf3D LGPL-2.1+ MIT public-domain"
SLOT="0"
KEYWORDS="~amd64"

PATCHES=(
	# This fixes the same symbol being used for globals in different objects
	# While linkers should be able to unravel this could lead to optimization
	# issues.
	# See:
	"${FILESDIR}/${P}-missing-include-guards.patch"
	"${FILESDIR}/${P}-sdl_scancodes.patch"

	# This fixes an issue with accessing a 2D array like a 1D array
	# (i.e. acessing a [256][3] array by [0][69]
	# This should work in practice but leads to undefined behavior
	# which in turn can lead to problems with loop optimization
	# See: -Waggressive-loop-optimizations
	"${FILESDIR}/${P}-oobarrayusage.patch"
)
