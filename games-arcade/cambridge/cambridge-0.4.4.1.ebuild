# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop

DESCRIPTION="The next open source block stacking game"
HOMEPAGE="https://t-sp.in/cambridge/"
SRC_URI="https://github.com/cambridge-stacker/cambridge/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

# BEWARE: The discord functionality is closed non-free
LICENSE="MIT discord? ( all-rights-reserved no-source-code )"
SLOT="0"
KEYWORDS="~amd64"
IUSE="discord"

# We need love to be compiled with luajit for ffi
DEPEND=">=games-engines/love-11.5[lua_single_target_luajit]"
RDEPEND="${DEPEND}"

src_install() {
	insinto "/usr/share/${PN}"

	doins -r load
	doins -r res
	doins -r scene
	doins -r tetris
	doins *.lua

	insinto "/usr/share/${PN}/libs"
	doins -r libs/bigint
	doins libs/*.lua

	if use discord; then
		doins libs/discord-rpc.so
		insinto "/usr/share/${PN}/libs/discordGameSDK/lib/x86_64"
		doins libs/discordGameSDK/lib/x86_64/discord_game_sdk.so
	fi

	make_desktop_entry "love /usr/share/${PN}" "Cambridge" "/usr/share/${PN}/res/img/cambridge_transparent.png" "Game"
}
