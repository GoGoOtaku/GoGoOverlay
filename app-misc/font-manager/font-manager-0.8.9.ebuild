# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2 meson vala

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/FontManager/font-manager.git"
	SRC_URI=""
else
	SRC_URI="https://github.com/FontManager/font-manager/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 x86"
fi

DESCRIPTION="A simple font management application for Gtk+ Desktop Environments"
HOMEPAGE="https://fontmanager.github.io"

VALA_MIN_API_VERSION=0.44
VALA_USE_DEPEND="vapigen"

LICENSE="GPL-3"
SLOT="0"
IUSE="doc gnome-search-provider google-fonts +manager nautilus nemo reproducible thunar +viewer +nls"

RDEPEND="gnome-base/gnome-common
	>=media-libs/fontconfig-2.12
	>=media-libs/freetype-2.5
	>=dev-libs/json-glib-0.15
	>=dev-libs/glib-2.62
	>=x11-libs/gtk+-3.22
	>=media-libs/harfbuzz-2.0
	>=x11-libs/pango-1.4
	>=dev-db/sqlite-3.8
	>=dev-libs/libxml2-2.9
	google-fonts? (
		>=net-libs/libsoup-3.0
		>=net-libs/webkit-gtk-2.42
	)
	nemo? ( gnome-extra/nemo )
	nautilus? ( gnome-base/nautilus )
	thunar? ( xfce-base/thunar )
"

DEPEND="${RDEPEND}
	$(vala_depend)
	doc? (
		app-text/yelp-tools
		dev-util/gtk-doc
	)
"

PATCHES=()

src_prepare() {
	default
	vala_setup
	gnome2_src_prepare
}

src_configure() {
	meson_src_configure \
		$(meson_use manager) \
		$(meson_use viewer) \
		$(meson_use reproducible) \
		$(meson_use nautilus) \
		$(meson_use nemo) \
		$(meson_use thunar) \
		$(meson_use gnome-search-provider search-provider) \
		$(meson_use google-fonts webkit) \
		$(meson_use nls enable-nls) \
		$(meson_use doc yelp-doc) \
		$(meson_use doc gtk-doc)
}
