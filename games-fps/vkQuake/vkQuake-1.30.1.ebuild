# Copyright 1999-2020 Ophelia Beatrice de Sica
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Vulkan Quake port based on QuakeSpasm"
HOMEPAGE="https://github.com/Novum/vkQuake"

if [[ ${PV} = "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Novum/vkQuake.git"
else
	SRC_URI="https://github.com/Novum/vkQuake/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
fi

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+wav flac opus modplug mikmod xmp umx +mad mpg123 +vorbis tremor"
REQUIRED_USE="
	^^ ( mad mpg123 )
	^^ ( vorbis tremor )
	^^ ( modplug mikmod xmp umx )"

BDEPEND="virtual/pkgconfig"
DEPEND="
	media-libs/libsdl2[vulkan]
	media-libs/vulkan-loader
	x11-libs/libX11
	flac? ( media-libs/flac )
	mad? ( media-libs/libmad )
	mpg123? ( media-sound/mpg123 )
	tremor? ( media-libs/tremor )
	vorbis? ( media-libs/libvorbis )
	mikmod? ( media-libs/libmikmod )
	modplug? ( media-libs/libmodplug )"

RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}/Quake"

src_compile() {
	local myemakeopts=(
		# Enable/Disable user directories support
		DO_USERDIRS=1

		### Enable/Disable codecs for streaming music support
		USE_CODEC_WAVE=$(usex wav 1 0)
		USE_CODEC_FLAC=$(usex flac 1 0)
		USE_CODEC_MP3=$(usex mad 1 $(usex mpg123 1 0))
		USE_CODEC_VORBIS=$(usex vorbis 1 $(usex tremor 1 0))
		USE_CODEC_OPUS=$(usex opus 1 0)

		# either mikmod, or xmp
		USE_CODEC_MODPLUG=$(usex modplug 1 0)
		USE_CODEC_MIKMOD=$(usex mikmod 1 0)
		USE_CODEC_XMP=$(usex xmp 1 0)
		USE_CODEC_UMX=$(usex umx 1 0)

		# which library to use for mp3 decoding: mad or mpg123
		MP3LIB=$(usex mad mad $(usex mpg123 mpg123))

		# which library to use for ogg decoding: vorbis or tremor
		VORBISLIB=$(usex vorbis vorbis $(usex tremor tremor))
	)

	emake release "${myemakeopts[@]}"
}

src_install() {
	dobin vkquake
}

