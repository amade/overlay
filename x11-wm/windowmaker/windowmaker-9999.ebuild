# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit autotools eutils git-2

DESCRIPTION="The fast and light GNUstep window manager"
HOMEPAGE="http://www.windowmaker.org/"
SRC_URI="http://www.windowmaker.org/pub/source/release/WindowMaker-extra-0.1.tar.gz"
EGIT_REPO_URI="git://repo.or.cz/wmaker-crm.git"
EGIT_BRANCH="next"

SLOT="0"
LICENSE="GPL-2"
IUSE="gif imagemagick jpeg modelock nls png tiff webp xinerama xrandr"
KEYWORDS="amd64 ~amd64"

DEPEND="media-libs/fontconfig
	>=x11-libs/libXft-2.1.0
	x11-libs/libXmu
	x11-libs/libXt
	x11-libs/libXv
	gif? ( >=media-libs/giflib-4.1.0-r3 )
	imagemagick? ( media-gfx/imagemagick )
	jpeg? ( virtual/jpeg )
	png? ( media-libs/libpng:0= )
	tiff? ( media-libs/tiff:0 )
	webp? ( media-libs/libwebp )
	xinerama? ( x11-libs/libXinerama )
	xrandr? ( x11-libs/libXrandr )"
RDEPEND="${DEPEND}
	nls? ( >=sys-devel/gettext-0.10.39 )"

src_unpack() {
	# wm-extras
	unpack ${A}

	git-2_src_unpack
}

src_prepare() {
	# Fix some paths
	for file in WindowMaker/*menu* util/wmgenmenu.c; do
		if [[ -r $file ]] ; then
			sed -i -e "s:/usr/local/GNUstep/Applications/WPrefs.app:${EPREFIX}/usr/bin/:g;" "$file" || die
			sed -i -e "s:/usr/local/share/WindowMaker:${EPREFIX}/usr/share/WindowMaker:g;" "$file" || die
			sed -i -e "s:/opt/share/WindowMaker:${EPREFIX}/usr/share/WindowMaker:g;" "$file" || die
		fi;
	done;

	eautoreconf
}

src_configure() {
	local myconf

	# image format types
	# xpm is provided by X itself
	myconf="--enable-xpm $(use_enable imagemagick magick) $(use_enable jpeg) $(use_enable gif) $(use_enable png) $(use_enable tiff) $(use_enable webp)"

	# non required X capabilities
	myconf="${myconf} $(use_enable modelock) $(use_enable xrandr randr) $(use_enable xinerama)"

	if use nls; then
		[[ -z $LINGUAS ]] && export LINGUAS="`ls po/*.po | sed 's:po/\(.*\)\.po$:\1:'`"
	else
		myconf="${myconf} --disable-locale"
	fi

	# default settings with $myconf appended
	econf \
		--sysconfdir="${EPREFIX}"/etc/X11 \
		--with-x \
		--enable-usermenu \
		--with-pixmapdir="${EPREFIX}"/usr/share/pixmaps \
		--with-nlsdir="${EPREFIX}"/usr/share/locale \
		${myconf}

	cd ../WindowMaker-extra-0.1
	econf
}

src_compile() {
	emake

	# WindowMaker Extra Package (themes and icons)
	cd ../WindowMaker-extra-0.1
	emake
}

src_install() {
	emake DESTDIR="${D}" install

	dodoc AUTHORS BUGFORM BUGS ChangeLog INSTALL* FAQ* \
		  README* NEWS TODO

	# WindowMaker Extra
	cd ../WindowMaker-extra-0.1
	emake DESTDIR="${D}" install

	newdoc README README.extra

	# create wmaker session shell script
	echo "#!/usr/bin/env bash" > wmaker
	echo "${EPREFIX}/usr/bin/wmaker" >> wmaker
	exeinto /etc/X11/Sessions/
	doexe wmaker

	insinto /usr/share/xsessions
	doins "${FILESDIR}"/wmaker.desktop
	make_desktop_entry /usr/bin/wmaker
}
