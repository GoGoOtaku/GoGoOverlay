# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

if [[ "$PV" = "20260706" ]];then
PHASH="6f8310e238fc3ce68f42f391cbe93fd156bb2c23"
fi

DESCRIPTION="C library that may be linked to produce symbolic backtraces"
HOMEPAGE="https://github.com/ianlancetaylor/libbacktrace"
SRC_URI="https://github.com/ianlancetaylor/libbacktrace/archive/${PHASH}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/libbacktrace-${PHASH}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
