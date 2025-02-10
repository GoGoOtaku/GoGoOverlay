# Copyright 1999-2020 Ophelia Beatrice de Sica
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="A MIDI Compiler - convert SMF MIDI files to and from plain text"
HOMEPAGE="https://github.com/markc/midicomp"
EGIT_REPO_URI="https://github.com/markc/midicomp.git"

LICENSE="AGPL-3"
SLOT="0"

src_configure() {
	cmake_src_configure
}

src_install() {
	cmake_src_install
}
