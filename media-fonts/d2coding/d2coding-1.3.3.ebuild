# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

if [[ "${PV}" == "1.3.3" ]]; then
	PVDATE="Ver${PV}-20260725"
fi

DESCRIPTION="D2 Coding Font (Hangul)"
HOMEPAGE="https://github.com/naver/d2codingfont"
SRC_URI="https://github.com/naver/d2codingfont/releases/download/VER${PV}/D2Coding-${PVDATE}.zip"

S="${WORKDIR}"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86"

RDEPEND="${DEPEND}"
BDEPEND="
	app-arch/unzip
"

FONT_S="${S}/fonts"
FONT_SUFFIX="ttf"

src_install() {
	mkdir -p "${FONT_S}" || die '"mkdir" failed.'

	mv "${S}/D2Coding/D2Coding-${PVDATE}.ttf" "${FONT_S}/"
	mv "${S}/D2Coding/D2CodingBold-${PVDATE}.ttf" "${FONT_S}/"
	mv "${S}/D2CodingLigature/D2Coding-${PVDATE}-ligature.ttf" "${FONT_S}/"
	mv "${S}/D2CodingLigature/D2CodingBold-${PVDATE}-ligature.ttf" "${FONT_S}/"

	font_src_install
}
