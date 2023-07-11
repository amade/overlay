# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_8 python3_9 )
inherit distutils-r1

DESCRIPTION="Read metadata (tags) of mp3, mp4, wma, ogg, flac and aiff files."
HOMEPAGE="https://github.com/hsoft/hsaudiotag"
SRC_URI="https://files.pythonhosted.org/packages/6e/4a/117ded92d098ee203391a5712a54ff87b391e7637029a08e68957e399701/${PN}-${PV}.post1.tar.gz -> ${P}.tar.gz"

KEYWORDS="amd64 x86 arm"
LICENSE="BSD"
SLOT="0"

RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

S="${WORKDIR}"/${P}.post1
