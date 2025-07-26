# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

PH="1c203fe1d670e5f3123c8f61523f437d58964ce4"

DESCRIPTION="Ports of Keen Dreams, the 3D Catacomb games and Wolfenstein 3D"
HOMEPAGE="https://github.com/ReflectionHLE/ReflectionHLE"
SRC_URI="https://github.com/ReflectionHLE/ReflectionHLE/archive/${PH}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/ReflectionHLE-${PH}

LICENSE="GPL-2+ BSD ID-Wolf3D LGPL-2.1+ MIT public-domain"
SLOT="0"
