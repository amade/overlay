# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_8 python3_9 )
inherit distutils-r1

DESCRIPTION="PyLyrics is a python module to get Lyrics of songs from lyrics.wikia.com."
HOMEPAGE="http://github.com/geekpradd/PyLyrics"
SRC_URI="https://files.pythonhosted.org/packages/9d/74/8e92322cb1425739849eb719c3b5d8ca05a6b1f027829fd56b4db7c4b7c7/${P}.zip"

KEYWORDS="amd64 x86 arm"
LICENSE="BSD"
SLOT="0"

RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
