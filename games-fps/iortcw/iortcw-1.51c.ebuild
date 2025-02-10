# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg-utils toolchain-funcs

DESCRIPTION="ioquake3 port of Return to Castle Wolfenstein"
HOMEPAGE="https://github.com/iortcw/iortcw"
SRC_URI="https://github.com/iortcw/iortcw/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3 ZLIB RSA"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+starter +bloom debug +openal +vorbis +opus +freetype +voip mumble +xdg yacc
	+system-ogg +system-vorbis +system-opus +system-zlib +system-jpeg +system-freetype "

DEPEND="
	dev-util/glslang
	media-libs/libsdl2
	net-misc/curl
	virtual/opengl

	openal? ( media-libs/openal )
	system-vorbis? ( media-libs/libvorbis )
	system-opus? (
		media-libs/opus
		media-libs/opusfile
	)
	system-zlib? ( sys-libs/zlib )
	system-jpeg? ( media-libs/libjpeg-turbo )
	system-freetype? ( media-libs/freetype )
	system-ogg? ( media-libs/libogg )
	mumble? ( net-voip/mumble )
	starter? ( sys-fs/unionfs-fuse )
"
RDEPEND="${DEPEND}"

case ${ARCH} in
	amd64)
		WOLFARCH=x86_64 ;;
	*)
		WOLFARCH=${ARCH} ;;
esac

src_compile() {
	local makeconf="\
		$(usex debug debug release) \
		ARCH=${WOLFARCH} \
		USE_OPENAL=$(usex openal 1 0) \
		USE_CODEC_VORBIS=$(usex vorbis 1 0) \
		USE_CODEC_OPUS=$(usex opus 1 0) \
		USE_MUMBLE=$(usex mumble 1 0) \
		USE_VOIP=$(usex voip 1 0) \
		USE_FREETYPE=$(usex freetype 1 0) \
		USE_INTERNAL_LIBS=0 \
		USE_INTERNAL_OGG=$(usex system-ogg 0 1) \
		USE_INTERNAL_VORBIS=$(usex system-vorbis 0 1) \
		USE_INTERNAL_OPUS=$(usex system-opus 0 1) \
		USE_INTERNAL_ZLIB=$(usex system-zlib 0 1) \
		USE_INTERNAL_JPEG=$(usex system-jpeg 0 1) \
		USE_INTERNAL_FREETYPE=$(usex system-freetype 0 1) \
		USE_LOCAL_HEADERS=0 \
		USE_XDG=$(usex xdg 1 0) \
		USE_YACC=$(usex yacc 1 0) \
		USE_BLOOM=$(usex bloom 1 0) \
		USE_OPENGLES=0 \
		COPYDIR=/usr/share/rtcw \
		COPYBINDIR=/usr/bin \
		TOOLS_CC=$(tc-getCC) \
		FULLBINEXT= \
	"

	emake ${makeconf} -C SP
	emake ${makeconf} -C MP
}

src_install() {
	local BUILD_TYPE=$(usex debug debug release)

	SP=${S}/SP/build/${BUILD_TYPE}-linux-${WOLFARCH}/
	MP=${S}/MP/build/${BUILD_TYPE}-linux-${WOLFARCH}/

	if use starter ; then
		dobin "${FILESDIR}/iortcw"
	fi

	exeinto /usr/lib/${PN}
	doexe ${SP}iowolfsp ${MP}iowolfded ${MP}iowolfmp

	insinto /usr/lib/${PN}
	doins ${SP}renderer_sp_opengl1_${WOLFARCH}.so ${SP}renderer_sp_rend2_${WOLFARCH}.so
	doins ${MP}renderer_mp_opengl1_${WOLFARCH}.so ${MP}renderer_mp_rend2_${WOLFARCH}.so

	insinto /usr/lib/${PN}/main
	doins ${SP}main/cgame.sp.${WOLFARCH}.so ${SP}main/qagame.sp.${WOLFARCH}.so ${SP}main/ui.sp.${WOLFARCH}.so
	doins ${MP}main/cgame.mp.${WOLFARCH}.so ${MP}main/qagame.mp.${WOLFARCH}.so ${MP}main/ui.mp.${WOLFARCH}.so

	insinto /usr/lib/${PN}/main/vm
	doins ${MP}main/vm/cgame.mp.qvm ${MP}main/vm/qagame.mp.qvm ${MP}main/vm/ui.mp.qvm
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
