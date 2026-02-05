# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg-utils

DESCRIPTION="Build Engine Games port based on EDuke32"
HOMEPAGE="https://github.com/NBlood/NBlood"
SRC_URI="https://github.com/NBlood/NBlood/archive/refs/tags/r${PV}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/NBlood-r${PV}

LICENSE="BUILDLIC GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+nblood +pcexhumed +rednukem voidsw etekwar ewitchaven +server +tools force-short-tool-names +opengl +gtk +vpx xmp asm clang debug"
REQUIRED_USE="
	|| ( nblood pcexhumed rednukem voidsw etekwar ewitchaven )
"

# There are no tests,
# instead it tries to build a test game, which does not compile
RESTRICT="bindist test"

DEPEND="
	media-libs/flac:=
	media-libs/libogg
	media-libs/libsdl2[alsa,joystick,opengl?,sound,video]
	media-libs/libvorbis
	media-libs/sdl2-mixer[flac,midi,vorbis]
	virtual/zlib
	gtk? ( x11-libs/gtk+:2 )
	opengl? (
		virtual/glu
		virtual/opengl
	)
	vpx? ( media-libs/libvpx:= )
	xmp? ( media-libs/exempi:2= )

	asm? ( dev-lang/nasm )

	voidsw? ( !!games-fps/eduke32[voidsw] )
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/no_clip_shape.patch"
)

src_compile() {
	local myemakeopts=(
		RELEASE=1
		PACKAGE_REPOSITORY=1

		# Toggles
		CPLUSPLUS=1
		MEMMAP=$(usex debug 1 0)
		$(use clang ? CLANG=1)
		$(use clang ? LLD=1)
		NOASM=$(usex asm 0 1)

		# Feature toggles
		NETCODE=$(usex server 1 0)
		NOONE_EXTENSIONS=1
		POLYMER=$(usex opengl 1 0)
		RETAIL_MENU=0
		STANDALONE=0
		STARTUP_WINDOW=$(usex gtk 1 0)

		# Library toggles
		HAVE_FLAC=1
		HAVE_GTK2=$(usex gtk 1 0)
		HAVE_VORBIS=1
		HAVE_XMP=$(usex xmp 1 0)
		RENDERTYPE=SDL
		SDL_FRAMEWORK=0
		SDL_STATIC=0
		SDL_TARGET=2
		USE_LIBVPX=$(usex vpx 1 0)
		USE_MIMALLOC=1
		USE_OPENGL=$(usex opengl 1 0)
		USE_PHYSFS=0

		# Debugging/Build options
		ALLOCACHE_AS_MALLOC=$(usex debug 1 0) # valgrind/gdb
		FORCEDEBUG=$(usex clang 2 1)
		KRANDDEBUG=$(usex debug 1 0)
		MICROPROFILE=$(usex debug 1 0) # valgrind/gdb
		PROFILER=$(usex debug 1 0)

		# Gentoo
		STRIP=""
	)

	local targets=( all )
	if use voidsw; then
		targets+=( sw )
	fi
	if use ewitchaven; then
		targets+=( witchaven )
	fi
	if use etekwar; then
		targets+=( tekwar )
	fi
	if use tools; then
		targets+=( tools )
	fi

	emake ${targets[@]} "${myemakeopts[@]}"
}

src_install() {
	if use nblood; then
		dobin nblood
		insinto /usr/share/nblood
		doins nblood.pk3
		make_desktop_entry nblood NBlood nblood Game
	fi

	make_desktop_entry mapster32 Mapster32 eduke32 Game
	use voidsw && make_desktop_entry voidsw-bin VoidSW voidsw Game

	if use pcexhumed; then
		dobin pcexhumed
		insinto /usr/share/pcexhumed
		doins pcexhumed.pk3
		make_desktop_entry pcexhumed PCExhumed pcexhumed Game
	fi

	if use rednukem; then
		dobin rednukem
		insinto /usr/share/rednukem
		doins dn64widescreen.pk3
		make_desktop_entry rednukem Rednukem rednukem Game
	fi

	if use voidsw; then
		dobin voidsw
		make_desktop_entry voidsw "Void Shadow Warrior" voidsw Game
	fi

	if use etekwar; then
		dobin etekwar
		make_desktop_entry etekwar "William Shatner's TekWar" etekwar Game
	fi

	if use ewitchaven; then
		dobin ewitchaven
		make_desktop_entry ewitchaven "Witchaven" ewitchaven Game
	fi

	if use tools; then
		local tools=()
		if use force-short-tool-names; then
			dobin arttool
			dobin bsuite
			dobin cacheinfo
			dobin generateicon
			dobin givedepth
			dobin ivfrate
			dobin kextract
			dobin kgroup
			dobin kmd2tool
			dobin makesdlkeytrans
			dobin map2stl
			dobin md2tool
			dobin mkpalette
			dobin transpal
			dobin unpackssi
			dobin wad2art
			dobin wad2map
		else
			newbin {,nblood-}arttool
			newbin {,nblood-}bsuite
			newbin {,nblood-}cacheinfo
			newbin {,nblood-}generateicon
			newbin {,nblood-}givedepth
			newbin {,nblood-}ivfrate
			newbin {,nblood-}kextract
			newbin {,nblood-}kgroup
			newbin {,nblood-}kmd2tool
			newbin {,nblood-}makesdlkeytrans
			newbin {,nblood-}map2stl
			newbin {,nblood-}md2tool
			newbin {,nblood-}mkpalette
			newbin {,nblood-}transpal
			newbin {,nblood-}unpackssi
			newbin {,nblood-}wad2art
			newbin {,nblood-}wad2map
		fi
	fi
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
