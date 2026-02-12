# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

if [[ "${PV}" == "20260125" ]]; then
	PH="9c9da268908cf761a3a875bd28a087389a21d215"
fi

DESCRIPTION="Ports of Keen Dreams, the 3D Catacomb games and Wolfenstein 3D"
HOMEPAGE="https://github.com/ReflectionHLE/ReflectionHLE"
SRC_URI="https://github.com/ReflectionHLE/ReflectionHLE/archive/${PH}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/ReflectionHLE-${PH}

LICENSE="GPL-2+ BSD ID-Wolf3D LGPL-2.1+ MIT public-domain"
SLOT="0"
KEYWORDS="~amd64"
