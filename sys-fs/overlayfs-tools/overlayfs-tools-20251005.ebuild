# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

if [[ "${PV}" -eq "20251005" ]]; then
PSHA="1ccb44553f850913c7b89a64d2572f07df3ddbf9"
fi

DESCRIPTION="Maintenance tools for overlay-filesystem"
HOMEPAGE="https://github.com/kmxz/overlayfs-tools"
SRC_URI="https://github.com/whole-tale/overlayfs-tools/archive/${PSHA}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}-${PSHA}"

LICENSE="WTFPL-2"
SLOT="0"
KEYWORDS="~amd64"
