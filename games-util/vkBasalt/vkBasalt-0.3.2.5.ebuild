# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# Copied from thegreatmcpain repository

EAPI=7

MULTILIB_COMPAT=( abi_x86_{32,64} )

inherit meson multilib-minimal

DESCRIPTION="A vulkan post processing layer"
HOMEPAGE="https://github.com/DadSchoorse/vkBasalt"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/DadSchoorse/vkBasalt.git"
	EGIT_SUBMODULES=()
else
	SRC_URI="https://github.com/DadSchoorse/vkBasalt/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="ZLIB"
SLOT="0"

RESTRICT="test"

RDEPEND="
	>=media-libs/vulkan-loader-1.1:=[${MULTILIB_USEDEP},layers]
"

BDEPEND="
	>=dev-util/meson-0.49
	>=dev-util/vulkan-headers-1.1
	dev-util/glslang
	x11-libs/libX11[${MULTILIB_USEDEP}]
"

DEPEND="${RDEPEND}"

multilib_src_configure() {
	meson_src_configure
}

multilib_src_compile() {
	meson_src_compile
}

multilib_src_install() {
	meson_src_install
}

multilib_src_install_all() {
	dodoc "${S}/config/vkBasalt.conf"
}

pkg_postinst() {
	einfo ""
	einfo "An example config exists in: /usr/share/doc/${P}/vkBasalt.conf.bz2"
	einfo "You may install it to your ~/.config like so."
	einfo ""
	einfo "'$ mkdir -v ~/.config/vkBasalt'"
	einfo ""
	einfo "'$ bzcat /usr/share/doc/${P}/vkBasalt.conf.bz2 > ~/.config/vkBasalt/vkBasalt.conf'"
	einfo ""
}

