# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_8 python3_9 )
DISTUTILS_USE_SETUPTOOLS=rdepend
inherit distutils-r1

DESCRIPTION="Python high-level interface and ctypes-based bindings for PulseAudio"
HOMEPAGE="http://github.com/mk-fg/python-pulse-control"
SRC_URI="https://files.pythonhosted.org/packages/82/50/9ab6147b657b20c1a7c3b72b285fc94f572c6005735bb0364a40f8b337a1/${P}.tar.gz"

KEYWORDS="amd64 x86 arm"
LICENSE="BSD"
SLOT="0"

RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
