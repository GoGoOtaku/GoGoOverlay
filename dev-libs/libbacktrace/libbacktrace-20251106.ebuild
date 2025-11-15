# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PHASH="b9e40069c0b47a722286b94eb5231f7f05c08713"

DESCRIPTION="C library that may be linked to produce symbolic backtraces"
HOMEPAGE="https://github.com/ianlancetaylor/libbacktrace"
SRC_URI="https://github.com/ianlancetaylor/libbacktrace/archive/${PHASH}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/libbacktrace-${PHASH}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
