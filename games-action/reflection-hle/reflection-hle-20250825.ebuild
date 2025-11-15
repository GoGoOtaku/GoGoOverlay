# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

if [[ "${PV}" == "20250825" ]]; then
	PH="b18f91a906099ed4bd3976cc24b5db50ef9ac492"
fi

DESCRIPTION="Ports of Keen Dreams, the 3D Catacomb games and Wolfenstein 3D"
HOMEPAGE="https://github.com/ReflectionHLE/ReflectionHLE"
SRC_URI="https://github.com/ReflectionHLE/ReflectionHLE/archive/${PH}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/ReflectionHLE-${PH}

LICENSE="GPL-2+ BSD ID-Wolf3D LGPL-2.1+ MIT public-domain"
SLOT="0"
KEYWORDS="~amd64"
