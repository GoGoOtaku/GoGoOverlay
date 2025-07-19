# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PHASH="793921876c981ce49759114d7bb89bb89b2d3a2d"

DESCRIPTION="C library that may be linked to produce symbolic backtraces"
HOMEPAGE="https://github.com/ianlancetaylor/libbacktrace"
SRC_URI="https://github.com/ianlancetaylor/libbacktrace/archive/${PHASH}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/libbacktrace-${PHASH}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
