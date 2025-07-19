# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson bash-completion-r1

DESCRIPTION="Inspect and build Windows Installer files"
HOMEPAGE="https://wiki.gnome.org/msitools"
SRC_URI="https://gitlab.gnome.org/GNOME/msitools/-/archive/v${PV}/msitools-v${PV}.tar.bz2"
S="${WORKDIR}/msitools-v${PV}"

# LGPL-2.1+
#	*
# blessing
#	libmsi/tokenize.c
#	tools/sqldelim.*
# GPL-2+
#	tools/msidiff.in
#	tools/msidump.in
#	tools/msibuild.c
#	tools/msiinfo.c
#	data/wxi-validate.pl
# GPL-3+
#	build-aux/git-version-gen
# MS-RL
#	data/ext/ui/*
# See copyright notice in the project repo for comment on GPL/MS-RL mixing
LICENSE="LGPL-2.1+ blessing GPL-2+ GPL-3+ non-free? ( MS-RL )"
SLOT="0"
KEYWORDS="~amd64"
IUSE="non-free"

DEPEND="
	>=app-arch/gcab-0.1.10[vala]
	>=dev-libs/glib-2.12
	>=dev-libs/libxml2-2.7
	dev-lang/perl
	gnome-extra/libgsf
	sys-devel/bison
	dev-util/bats
"
RDEPEND="${DEPEND}"

src_prepare() {
	eapply "${FILESDIR}/fix-bats.patch"

	if ( ! use non-free ); then
		eapply "${FILESDIR}/non-free.patch"
	fi

	echo "${PV}" > "${S}/.tarball-version"

	eapply_user
}

src_install() {
	meson_install

	newbashcomp "${D}/$(get_bashcompdir)/msitools" msiinfo
	bashcomp_alias msiinfo msibuild

	rm "${D}/$(get_bashcompdir)/msitools"
}
