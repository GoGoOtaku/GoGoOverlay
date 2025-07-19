# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Hexen II: Hammer of Thyrion - A cross-platform port of Hexen II"
HOMEPAGE="http://uhexen2.sourceforge.net/"
SRC_URI="https://github.com/sezero/uhexen2/archive/refs/tags/${P}.tar.gz"
S="${WORKDIR}/${PN}-${P}"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"
# gamecode
IUSE="
	+soft +opengl
	+alsa oss wav flac
	+vorbis opus mikmod +modplug xmp umx timidity wildmidi +mad mpg123 tremor
	+client server utils world
	demo debug"
REQUIRED_USE="
	|| ( soft opengl )
	^^ ( mad mpg123 )
	^^ ( vorbis tremor )
	^^ ( mikmod modplug xmp umx )"

DEPEND="
	media-libs/libglvnd
	media-libs/libsdl

	mad? ( media-libs/libmad )
	mpg123? ( media-sound/mpg123 )
	vorbis? ( media-libs/libogg media-libs/libvorbis )
	tremor? ( media-libs/libogg media-libs/tremor )
	flac? ( media-libs/flac )
	opus? ( media-libs/libogg media-libs/opus media-libs/opusfile )
	mikmod? ( media-libs/libmikmod )
	modplug? ( media-libs/libmodplug )
	xmp? ( media-libs/libxmp )
	timidity? ( media-libs/libtimidity )
	wildmidi? ( media-sound/wildmidi )
"
RDEPEND="${DEPEND}"

BDIR="${WORKDIR}/build"

src_compile() {
	local myemakeopts=(
		USE_ALSA=$(usex alsa)
		USE_OSS=$(usex oss)
		USE_MIDI=$(usex timidity yes $(usex wildmidi yes no))

		### Enable/Disable codecs for streaming music support
		USE_CODEC_WAVE=$(usex wav)
		USE_CODEC_FLAC=$(usex flac)
		USE_CODEC_MP3=$(usex mpg123 yes $(usex mad yes no))
		USE_CODEC_VORBIS=$(usex vorbis yes $(usex tremor yes no))
		USE_CODEC_OPUS=$(usex opus)

		# either mikmod, or xmp
		USE_CODEC_MIKMOD=$(usex mikmod)
		USE_CODEC_XMP=$(usex xmp)
		USE_CODEC_UMX=$(usex umx)
		USE_CODEC_MODPLUG=$(usex modplug)

		# Midi
		USE_CODEC_TIMIDITY=$(usex timidity)
		USE_CODEC_WILDMIDI=$(usex wildmidi)

		# which library to use for mp3 decoding: mad or mpg123
		MP3LIB=$(usex mad mad $(usex mpg123 mpg123))

		# which library to use for ogg decoding: vorbis or tremor
		VORBISLIB=$(usex vorbis vorbis $(usex tremor tremor))

		DEMO=$(usex demo)
		DEBUG=$(usex debug)
	)

	mkdir -p ${BDIR}/bin
	mkdir -p ${BDIR}/share/uhexen2/bin

	if use client; then
		pushd "${S}/engine/hexen2"
		if use soft; then
			emake h2 "${myemakeopts[@]}"
			cp hexen2 "${BDIR}/bin/uhexen2"
			if use opengl; then
				# We need to clean since some created objects
				# use different code for opengl
				emake localclean
			fi
		fi
		if use opengl; then
			emake glh2 "${myemakeopts[@]}"
			cp glhexen2 "${BDIR}/bin/uglhexen2"
		fi
		popd

		if use world; then
			pushd "${S}/engine/hexenworld/client"
			if use soft; then
				emake hw "${myemakeopts[@]}"
				cp hwcl "${BDIR}/bin/uhexenworld"
				if use opengl; then
					# We need to clean since some created objects
					# use different code for opengl
					emake localclean
				fi
			fi
			if use opengl; then
				emake glhw "${myemakeopts[@]}"
				cp glhwcl "${BDIR}/bin/uglhexenworld"
			fi
			popd
		fi
	fi

	if use server; then
		pushd "${S}/engine/server"
		emake
		cp h2ded "${BDIR}/bin/uhexen2server"
		popd

		if use world; then
			pushd "${S}/engine/hexenworld/server"
			emake
			cp hwsv "${BDIR}/bin/uhexenworldserver"
			popd
		fi
	fi

	if use utils; then
		pushd "${S}/utils"
		cd bspinfo
		emake
		cp bspinfo "${BDIR}/share/uhexen2/bin/"
		cd ../hcc
		emake
		cp hcc "${BDIR}/share/uhexen2/bin/"
		cd ../dcc
		emake
		cp dhcc "${BDIR}/share/uhexen2/bin/"
		cd ../genmodel
		emake
		cp genmodel "${BDIR}/share/uhexen2/bin/"
		cd ../jsh2colour
		emake
		cp jsh2colour "${BDIR}/share/uhexen2/bin/"
		cd ../light
		emake
		cp light "${BDIR}/share/uhexen2/bin/"
		cd ../pak
		emake
		cp paklist pakx "${BDIR}/share/uhexen2/bin/"
		cd ../qbsp
		emake
		cp qbsp "${BDIR}/share/uhexen2/bin/"
		cd ../qfiles
		emake
		cp qfiles "${BDIR}/share/uhexen2/bin/"
		cd ../vis
		emake
		cp vis "${BDIR}/share/uhexen2/bin/"
		cd ../texutils/bsp2wal
		emake
		cp bsp2wal "${BDIR}/share/uhexen2/bin/"
		cd ../lmp2pcx
		emake
		cp lmp2pcx "${BDIR}/share/uhexen2/bin/"
		popd

		if use world; then
			pushd "${S}/hw_utils"
			cd hwmaster
			emake
			cp hwmaster "${BDIR}/share/uhexen2/bin/"
			cd ../hwmquery
			emake
			cp hwmquery "${BDIR}/share/uhexen2/bin/"
			cd ../hwrcon
			emake
			cp hwterm "${BDIR}/share/uhexen2/bin/"
			popd
		fi
	fi
}

src_install() {
	if use client; then
		if use soft; then
			dobin "${BDIR}/bin/uhexen2"
		fi
		if use opengl; then
			dobin "${BDIR}/bin/uglhexen2"
		fi

		if use world; then
			if use soft; then
				dobin "${BDIR}/bin/uhexenworld"
			fi
			if use opengl; then
				dobin "${BDIR}/bin/uglhexenworld"
			fi
		fi
	fi

	if use server; then
		dobin "${BDIR}/bin/uhexen2server"

		if use world; then
			dobin "${BDIR}/bin/uhexenworldserver"
		fi
	fi

	if use utils; then
		insinto "/usr/share/uhexen2"
		doins -r "${BDIR}/share/uhexen2"
	fi
}
