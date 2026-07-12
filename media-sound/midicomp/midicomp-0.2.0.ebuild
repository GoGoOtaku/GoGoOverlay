# Copyright 1999-2020 Ophelia Beatrice de Sica
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A MIDI Compiler - convert SMF MIDI files to and from plain text"
HOMEPAGE="https://github.com/markc/midicomp"
SRC_URI="https://github.com/markc/midicomp/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_configure() {
	cmake_src_configure
}

src_install() {
	cmake_src_install
}
