# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit autotools eutils

DESCRIPTION="An enhanced version of the game engine from the classic Mac game, Marathon"
HOMEPAGE="http://source.bungie.org/"
if [[ ${PV} = 9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Aleph-One-Marathon/alephone/"
	EGIT_SUBMODULES=()  # Do not need game data.
else
	KEYWORDS="~amd64 ~x86"
	SRC_URI="https://github.com/Aleph-One-Marathon/alephone/archive/refs/tags/release-${PV}.tar.gz"
	S="${WORKDIR}/${PN}-release-${PV}"
fi

LICENSE="GPL-3+ BitstreamVera OFL-1.1"
SLOT="0"

IUSE="alsa curl +ffmpeg -mad -mpeg -sndfile speex -vorbis"
REQUIRED_USE="
ffmpeg? ( !mad !mpeg !sndfile !vorbis )
mad? ( !ffmpeg )
mpeg? ( !ffmpeg )
sndfile? ( !ffmpeg )
vorbis? ( !ffmpeg )
"

RDEPEND="
	dev-libs/boost
	dev-libs/expat
	dev-libs/zziplib
	media-libs/libpng:0
	media-libs/libsdl[joystick,opengl,video]
	media-libs/sdl2-image[png]
	media-libs/sdl2-net
	media-libs/sdl2-ttf
	virtual/opengl
	virtual/glu
	alsa? ( media-libs/alsa-lib )
	curl? ( net-misc/curl )
	ffmpeg? ( media-video/ffmpeg )
	mad? ( media-libs/libmad )
	mpeg? ( media-libs/smpeg2 )
	sndfile? ( media-libs/libsndfile )
	speex? ( media-libs/speex )
	vorbis? ( media-libs/libvorbis )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"


src_prepare() {
	default

	sed "s:GAMES_DATADIR:/usr/share:g" \
		"${FILESDIR}"/${PN}.sh > "${T}"/${PN}.sh \
		|| die

	eautoreconf
}

src_configure() {
	econf \
		--enable-lua \
		--enable-opengl \
		$(use_with alsa) \
		$(use_with ffmpeg) \
		$(use_with mad) \
		$(use_with mpeg smpeg) \
		$(use_with sndfile) \
		$(use_with speex) \
		$(use_with vorbis)
}

src_install() {
	default
	dobin "${T}"/${PN}.sh
	doman docs/${PN}.6
	dodoc docs/*.html
}

pkg_postinst() {
	echo
	elog "Read the docs and install the data files accordingly to play."
	echo
	elog "If you only want to install one scenario, read"
	elog "http://traxus.bungie.org/index.php/Aleph_One_install_guide#Single_scenario_3"
	elog "If you want to install multiple scenarios, read"
	elog "http://traxus.bungie.org/index.php/Aleph_One_install_guide#Multiple_scenarios_3"
	echo
}
