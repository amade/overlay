# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/keepassx/keepassx-2.0_alpha5.ebuild,v 1.2 2014/01/14 14:20:26 polynomial-c Exp $

EAPI=5

inherit cmake-utils vcs-snapshot

DESCRIPTION="Qt password manager compatible with its Win32 and Pocket PC versions"
HOMEPAGE="http://www.keepassx.org/"
SRC_URI="https://github.com/${PN}/${PN}/archive/${PV/_/-}.tar.gz -> ${P}.tar.gz"

LICENSE="|| ( GPL-2 GPL-3 ) BSD GPL-2 LGPL-2.1 LGPL-3+ CC0-1.0 public-domain || ( LGPL-2.1 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE="dbus test"

DEPEND="
	dbus? (	dev-qt/qtdbus:4 )
	dev-libs/libgcrypt:=
	dev-qt/qtcore:4
	dev-qt/qtgui:4
	dev-qt/qttest:4
	sys-libs/zlib
	x11-libs/libX11
	x11-libs/libXtst
"
RDEPEND="${DEPEND}"

DOCS=(CHANGELOG)

src_prepare() {
	if ! use dbus; then
		epatch "${FILESDIR}"/${P}-nodbus.patch
	fi
	epatch "${FILESDIR}"/${P}-libgcrypt-1.6.0.patch
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with test TESTS)
	)
	cmake-utils_src_configure
}
