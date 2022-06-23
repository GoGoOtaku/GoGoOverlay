# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Keyboard driven Wayland notification daemon for wlroots-based compositors."
HOMEPAGE="https://codeberg.org/dnkl/fnott"
SRC_URI="https://codeberg.org/dnkl/fnott/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT ZLIB"
SLOT="0"
KEYWORDS="amd64"

DEPEND="
	dev-libs/wayland
	gui-libs/wlroots
	media-libs/fcft
	media-libs/fontconfig
	media-libs/freetype
	media-libs/libpng
	sys-apps/dbus
	x11-libs/pixman
"
RDEPEND="${DEPEND}"
BDEPEND="
	app-text/scdoc
	dev-libs/tllist
	dev-libs/wayland-protocols
	dev-util/meson
	dev-util/ninja
"
S="${WORKDIR}/${PN}"

src_install() {
	meson_src_install

	mkdir -p ${D}/usr/lib/systemd/user
	mkdir -p ${D}/usr/share/dbus-1/services

	cat << EOF > "${D}/usr/lib/systemd/user/fnott.service" || die
[Unit]
Description=fnott notification daemon
Documentation=man:fnott(1)
PartOf=graphical-session.target

[Service]
Type=dbus
BusName=org.freedesktop.Notifications
ExecStart=/usr/bin/fnott
EOF

	cat << EOF > "${D}/usr/share/dbus-1/services/org.dnkl.fnott.service" || die
[D-BUS Service]
Name=org.freedesktop.Notifications
Exec=/usr/bin/fnott
SystemdService=fnott.service
EOF
}
