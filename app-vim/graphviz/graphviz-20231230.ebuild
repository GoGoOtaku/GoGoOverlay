# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit vim-plugin vcs-snapshot

# Commit from the 30th December 2023
COMMIT="dbe1de334097891186e09e5616671091d89011d5"

DESCRIPTION="vim plugin: graphviz and dot file support"
HOMEPAGE="https://github.com/liuchengxu/graphviz.vim"
SRC_URI="https://github.com/liuchengxu/${PN}.vim/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="vim"
KEYWORDS="~amd64 ~x86"

VIM_PLUGIN_HELPFILES="${PN}.txt"

DOCS=( README.md )
