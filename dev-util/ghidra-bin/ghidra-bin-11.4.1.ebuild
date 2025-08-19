# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop

PD="20250731"

DESCRIPTION="Ghidra is a software reverse engineering (SRE) framework"
HOMEPAGE="https://ghidra-sre.org"
SRC_URI="https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_${PV}_build/ghidra_${PV}_PUBLIC_${PD}.zip -> ${P}.zip"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="strip"

DEPEND="virtual/jdk:21"
RDEPEND="${DEPEND}"
BDEPEND="app-arch/unzip"

src_unpack() {
	if [[ -n ${A} ]]; then
		unpack ${A}
	fi

	mv "${WORKDIR}/ghidra_${PV}_PUBLIC" "${WORKDIR}/${P}"
}

src_install() {
	insinto "/opt/"
	doins -r "${S}"

	# Restore executability to all files
	fperms 755 $(find -type f -executable | awk "{print \"/opt/${P}/\" \$0}")
	make_desktop_entry "/opt/${P}/ghidraRun" "Ghidra" "/opt/${P}/support/ghidra.ico"

	dosym -r "/opt/${P}/ghidraRun" "/usr/bin/${PN}"
}
