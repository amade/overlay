# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit user

DESCRIPTION="small DNS server that spoofs blacklisted addresses and forwards all other queries"
HOMEPAGE="https://opensource.conformal.com/wiki/Adsuck"
SRC_URI="https://opensource.conformal.com/snapshots/adsuck/${P}.tgz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-libs/libevent
net-libs/ldns"
RDEPEND="${DEPEND}"

src_install() {
	dosbin adsuck

    dodoc README

	doman *.8

	newinitd "${FILESDIR}"/${PN}.initd ${PN}
}

pkg_preinst() {
	enewgroup adsuck
	enewuser adsuck -1 -1 -1 "adsuck"
}
