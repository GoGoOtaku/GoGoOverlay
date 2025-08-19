# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PH="bed0999f96ee9869ed25e0f1439bef5eff341e22"

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
