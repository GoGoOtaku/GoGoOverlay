# Copyright 1999-2020 Ophelia Beatrice de Sica
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="A MIDI Compiler - convert SMF MIDI files to and from plain text"
HOMEPAGE="https://github.com/markc/midicomp"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/markc/midicomp.git"
	inherit git-r3
else 
	SRC_URI="https://github.com/markc/midicomp/archive/refs/tags/v${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="AGPL-3"
SLOT="0"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"
BDEPEND=""

src_configure() {
	cmake_src_configure
}

src_install() {
	cmake_src_install
}

