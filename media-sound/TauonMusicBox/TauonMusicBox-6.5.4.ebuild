# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A music player for the Linux desktop."
HOMEPAGE="https://tauonmusicbox.rocks"
SRC_URI="https://github.com/Taiko2k/${PN}/archive/refs/tags/v${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	app-arch/p7zip
	app-arch/unrar
	app-arch/unzip
	dev-python/PyLyrics
	dev-python/PySDL2
	dev-python/beautifulsoup
	dev-python/hsaudiotag3k
	dev-python/olefile
	dev-python/pillow
	dev-python/pulsectl
	dev-python/pylast
	dev-python/python-musicbrainz-ngs
	dev-python/send2trash
	dev-python/setproctitle
	dev-python/stagger
	dev-python/unidecode
	media-fonts/noto
	media-libs/libopenmpt
	media-libs/musicbrainz
	media-libs/opusfile
	media-libs/sdl2-image
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_compile() {
	python compile-translations.py
	bash compile-phazor.sh
}

src_install() {
	
	#doicon usr/share/${PN}/${PN}.png
	#domenu usr/share/${PN}/${PN}.desktop

	insinto /usr/share/applications
	doins extra/tauonmb.desktop

	insinto /usr/share/icons/hicolor/symbolic/apps
	doins extra/tauonmb-symbolic.svg

	insinto /usr/share/icons/hicolor/scalable/apps
	doins extra/tauonmb.svg

	exeinto /opt/tauon-music-box
	doexe extra/tauonmb.sh

	insinto /opt/tauon-music-box
	doins -r assets
	doins -r templates
	doins -r theme
	doins -r t_modules
	doins -r lib
	dosym ../../opt/tauon-music-box/tauonmb.sh usr/bin/tauon

}
