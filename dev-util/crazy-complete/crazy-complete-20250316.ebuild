# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools
DISTUTILS_SINGLE_IMPL=1

inherit distutils-r1
if [[ "${PV}" -eq "20250316" ]]; then
PH="1925342a76a139900f40830e24a7729b12cd8aed"
fi
DESCRIPTION="Generate shell auto completion files"
HOMEPAGE="https://github.com/crazy-complete/crazy-complete"
SRC_URI="https://github.com/crazy-complete/crazy-complete/archive/${PH}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${PH}"

LICENSE="GPL-3"
SLOT="0"

RESTRICT="test"

DEPEND="
	${PYTHON_DEPS}
	>=dev-python/pyyaml-6.0
"
RDEPEND="${DEPEND}"

src_install() {
	default
	distutils-r1_src_install

	dodoc "${S}/docs/commands.md"
	dodoc "${S}/docs/comparision.md"
	dodoc "${S}/docs/documentation.md"
}

# python_test() {
# 	"${EPYTHON}" ./test/test.py || die "Tests fail with ${EPYTHON}"
# 	"${EPYTHON}" ./test/utils.py || die "Tests fail with ${EPYTHON}"
# }

# python_test_all() {
# 	cd test/conversion/run.sh  || die
# }
