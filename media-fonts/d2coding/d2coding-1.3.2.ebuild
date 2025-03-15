# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

DESCRIPTION="D2 Coding Font (Hangul)"
HOMEPAGE="https://github.com/naver/d2codingfont"
SRC_URI="https://github.com/naver/d2codingfont/releases/download/VER1.3.2/D2Coding-Ver1.3.2-20180524.zip"

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

	mv "${S}/D2Coding/D2Coding-Ver1.3.2-20180524.ttf" "${FONT_S}/"
	mv "${S}/D2Coding/D2CodingBold-Ver1.3.2-20180524.ttf" "${FONT_S}/"
	mv "${S}/D2CodingLigature/D2Coding-Ver1.3.2-20180524-ligature.ttf" "${FONT_S}/"
	mv "${S}/D2CodingLigature/D2CodingBold-Ver1.3.2-20180524-ligature.ttf" "${FONT_S}/"

	font_src_install
}
