# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

if [[ "$PV" = "20260409" ]]; then
	PH="f856eb1fd4d265776d1d3cd1e65573188a431ea3"
fi

DESCRIPTION="Soothing pastel theme for Ghidra"
HOMEPAGE="https://github.com/catppuccin/ghidra"
SRC_URI="https://github.com/catppuccin/ghidra/archive/${PH}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/ghidra-${PH}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

src_install() {
	insinto /usr/share/ghidra
	doins -r "${S}/themes"
}
