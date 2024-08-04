# Copyright 1999-2020 Ophelia Beatrice de Sica
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Vulkan Quake port based on QuakeSpasm"
HOMEPAGE="https://github.com/Novum/vkQuake"
SRC_URI="https://github.com/Novum/vkQuake/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+wav flac opus +mad mpg123 +vorbis tremor"
REQUIRED_USE="
	^^ ( mad mpg123 )
	^^ ( vorbis tremor )"

BDEPEND="virtual/pkgconfig"
DEPEND="
	media-libs/libsdl2[vulkan]
	media-libs/vulkan-loader
	x11-libs/libX11
	flac? ( media-libs/flac )
	mad? ( media-libs/libmad )
	mpg123? ( media-sound/mpg123 )
	tremor? ( media-libs/tremor )
	vorbis? ( media-libs/libvorbis )"

RDEPEND="${DEPEND}"

src_compile() {
	local use_mp3=auto
	local mp3_lib=mad
	local use_vorbis=auto
	local vorbis_lib=vorbis

	if use mad; then
		use_mp3=enabled
		mp3_lib=mad
	elif use mpg123; then
		use_mp3=enabled
		mp3_lib=mpg123
	else
		use_mp3=disabled
	fi

	if use vorbis; then
		use_vorbis=enabled
		vorbis_lib=vorbis
	elif use tremor; then
		use_vorbis=enabled
		vorbis_lib=tremor
	else
		use_vorbis=disabled
	fi

	local emesonargs=(
		$(meson_feature wav use_codec_wave)
		-Duse_codec_mp3=$use_mp3
		$(meson_feature flac use_codec_flac)
		-Duse_codec_vorbis=$use_vorbis
		$(meson_feature opus use_codec_opus)
		-Dmp3_lib=$mp3_lib
		-Dvorbis_lib=$vorbis_lib

		# Enable/Disable user directories support
		-Ddo_userdirs=enabled
	)

	meson_src_configure
}

src_compile() {
	meson_src_compile
}

src_install() {
	dobin ${BUILD_DIR}/vkquake
}

