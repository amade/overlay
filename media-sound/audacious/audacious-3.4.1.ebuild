# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/audacious/audacious-3.4.1.ebuild,v 1.1 2013/09/02 21:13:01 jdhore Exp $

EAPI=5
inherit eutils

MY_P="${P/_/-}"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="Audacious Player - Your music, your way, no exceptions"
HOMEPAGE="http://audacious-media-player.org/"
SRC_URI="http://distfiles.audacious-media-player.org/${MY_P}.tar.bz2
	 mirror://gentoo/gentoo_ice-xmms-0.2.tar.bz2"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux"

IUSE="chardet dbus nls thunar"

RDEPEND="dbus? ( >=dev-libs/dbus-glib-0.60 )
	thunar? ( xfce-base/thunar )
	>=dev-libs/glib-2.28
	dev-libs/libxml2
	>=x11-libs/cairo-1.2.6
	>=x11-libs/pango-1.8.0
	x11-libs/gtk+:3"

DEPEND="${RDEPEND}
	virtual/pkgconfig
	chardet? ( >=app-i18n/libguess-1.1 )
	nls? ( dev-util/intltool )"

PDEPEND="~media-plugins/audacious-plugins-3.4.1"

src_configure() {
	econf \
		$(use_enable dbus) \
		$(use_enable chardet) \
		$(use_enable nls) \
		$(use_enable thunar)
}

src_install() {
	default
	dodoc AUTHORS

	# Gentoo_ice skin installation; bug #109772
	insinto /usr/share/audacious/Skins/gentoo_ice
	doins "${WORKDIR}"/gentoo_ice/*
	docinto gentoo_ice
	dodoc "${WORKDIR}"/README
}
