# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit gnome2-utils

MY_PN="${PN/-icon-theme/}"

DESCRIPTION="Elementary icons forked from upstream, extended and maintained for Xfce"
HOMEPAGE="https://github.com/shimmerproject/elementary-xfce"
SRC_URI="https://github.com/shimmerproject/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="public-domain GPL-1 GPL-2 GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="xubuntu"

RDEPEND=""
DEPEND="media-gfx/optipng"

S="${WORKDIR}/${MY_PN}-${PV}"

src_install() {
	insinto /usr/share/icons/

	if use xubuntu ; then
		unlink elementary-xfce/apps/48/xfce4-panel-menu.svg
		dosym /usr/share/icons/elementary-xfce/places/48/distributor-logo-xubuntu.svg \
			/usr/share/icons/elementary-xfce/apps/48/xfce4-panel-menu.svg
	fi
	dodoc README.md
	for shade in elementary-xfce*; do
		for doc in {AUTHORS,CONTRIBUTORS,LICENSE}; do
			if [[ -f ${shade}/${doc} ]]; then
				newdoc ${shade}/${doc} ${shade}-${doc}
				rm -f ${shade}/${doc} || die
			elif [[ -L ${shade}/${doc} ]]; then
				unlink ${shade}/${doc} || die
			fi
		done
		doins -r ${shade}
	done
}

pkg_preinst() { gnome2_icon_savelist; }
pkg_postinst() { gnome2_icon_cache_update; }
pkg_postrm() { gnome2_icon_cache_update; }
