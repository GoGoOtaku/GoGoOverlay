# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

if [[ "${PV}" -eq "20250124" ]]; then
PSHA="6e925bbbe747fbb58bc4a95a646907a2101741f6"
fi

DESCRIPTION="Maintenance tools for overlay-filesystem"
HOMEPAGE="https://github.com/kmxz/overlayfs-tools"
SRC_URI="https://github.com/whole-tale/overlayfs-tools/archive/${PSHA}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}-${PSHA}"

LICENSE="WTFPL-2"
SLOT="0"
KEYWORDS="~amd64"
