# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools
DISTUTILS_SINGLE_IMPL=1

inherit distutils-r1

DESCRIPTION="Generate shell auto completion files"
HOMEPAGE="https://github.com/crazy-complete/crazy-complete"
SRC_URI="https://github.com/crazy-complete/crazy-complete/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RESTRICT="test"

DEPEND="
	${PYTHON_DEPS}
	>=dev-python/pyyaml-6.0
"
RDEPEND="${DEPEND}"

src_install() {
	default
	distutils-r1_src_install

	dodoc "${S}/commands.md"
	dodoc "${S}/comparision.md"
	dodoc "${S}/documentation.md"
}

# python_test() {
# 	"${EPYTHON}" ./test/test.py || die "Tests fail with ${EPYTHON}"
# 	"${EPYTHON}" ./test/utils.py || die "Tests fail with ${EPYTHON}"
# }

# python_test_all() {
# 	cd test/conversion/run.sh  || die
# }
