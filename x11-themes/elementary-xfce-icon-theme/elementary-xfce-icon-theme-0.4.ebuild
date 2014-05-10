# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=4
inherit gnome2-utils

MY_PN="elementary-xfce"

DESCRIPTION="Elementary icons forked from upstream, extended and maintained for Xfce"
HOMEPAGE="http://github.com/shimmerproject/elementary-xfce"
SRC_URI="http://github.com/shimmerproject/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="gnome-base/librsvg"
DEPEND="${RDEPEND}"

RESTRICT="binchecks strip"

src_unpack() {
	unpack ${A}
	mv ${MY_PN}-* "${S}"
}

src_install() {
	insinto /usr/share/icons/
	doins -r elementary-xfce
	doins -r elementary-xfce-dark
	doins -r elementary-xfce-darker
	#doins -r index.theme apps
	#dodoc README
}

pkg_preinst() {	gnome2_icon_savelist; }
pkg_postinst() { gnome2_icon_cache_update; }
pkg_postrm() { gnome2_icon_cache_update; }
