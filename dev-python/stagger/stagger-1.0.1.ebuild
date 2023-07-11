# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_8 python3_9 )
DISTUTILS_USE_SETUPTOOLS=rdepend
inherit distutils-r1

DESCRIPTION="An ID3v1/ID3v2 tag manipulation package written in pure Python 3"
HOMEPAGE="https://github.com/staggerpkg/stagger"
SRC_URI="https://github.com/staggerpkg/${PN}/archive/refs/tags/release-${PV}.tar.gz"

KEYWORDS="amd64 x86 arm"
LICENSE="BSD"
SLOT="0"

RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

S="${WORKDIR}"/${PN}-release-${PV}
