# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools flag-o-matic git-r3 pam tmpfiles

DESCRIPTION="screen manager with VT100/ANSI terminal emulation"
HOMEPAGE="https://www.gnu.org/software/screen/"

EGIT_REPO_URI="https://git.savannah.gnu.org/git/screen.git"
EGIT_CHECKOUT_DIR="${WORKDIR}/${P}" # needed for setting S later on
S="${WORKDIR}"/${P}/src
KEYWORDS="~amd64"

LICENSE="GPL-3+"
SLOT="0"
IUSE="pam selinux telnet utmp"

DEPEND=">=sys-libs/ncurses-5.2:=
	virtual/libcrypt:=
	pam? ( sys-libs/pam )"
RDEPEND="${DEPEND}
	utmp? ( sys-libs/libutempter )
	selinux? ( sec-policy/selinux-screen )"
BDEPEND="sys-apps/texinfo"

src_prepare() {
	default

	# sched.h is a system header and causes problems with some C libraries
	mv sched.h _sched.h || die
	sed -i '/include/ s:sched\.h:_sched.h:' \
		screen.h winmsg.c window.h sched.c canvas.h || die
	sed -i 's@[[:space:]]sched\.h@ _sched.h@' Makefile.in || die

	# Fix manpage
	sed -i \
		-e "s:/usr/local/etc/screenrc:${EPREFIX}/etc/screenrc:g" \
		-e "s:/usr/local/screens:${EPREFIX}/tmp/screen:g" \
		-e "s:/local/etc/screenrc:${EPREFIX}/etc/screenrc:g" \
		-e "s:/etc/utmp:${EPREFIX}/var/run/utmp:g" \
		-e "s:/local/screens/S\\\-:${EPREFIX}/tmp/screen/S\\\-:g" \
		doc/screen.1 || die

	# disable musl dummy headers for utmp[x]
	use elibc_musl && append-cppflags "-D_UTMP_H -D_UTMPX_H"

	# reconfigure
	eautoreconf
}

src_configure() {
	append-cppflags "-DMAXWIN=${MAX_SCREEN_WINDOWS:-100}"

	local myeconfargs=(
		--enable-socket-dir="${EPREFIX}/run/${PN}"
		--with-system_screenrc="${EPREFIX}/etc/screenrc"
		--with-pty-mode=0620 \
		--with-pty-group=5 \
		$(use_enable pam) \
		$(use_enable telnet) \
		$(use_enable utmp)
	)
	econf "${myeconfargs[@]}"
}

src_compile() {
	LC_ALL=POSIX emake comm.h term.h

	emake -C doc screen.info
	default
}

src_install() {
	local DOCS=(
		README ChangeLog INSTALL TODO NEWS*
		doc/{FAQ,README.DOTSCREEN,fdpat.ps,window_to_display.ps}
	)

	emake DESTDIR="${D}" SCREEN="${P}" install

	local tmpfiles_perms tmpfiles_group

	fperms 2755 /usr/bin/${P}
	tmpfiles_perms="0775"

	newtmpfiles - screen.conf <<<"d /tmp/screen ${tmpfiles_perms} root ${tmpfiles_group}"

	insinto /usr/share/${PN}
	doins terminfo/{screencap,screeninfo.src}

	insinto /etc
	doins "${FILESDIR}"/screenrc

	if use pam; then
		pamd_mimic_system screen auth
	fi

	dodoc "${DOCS[@]}"
}

pkg_postinst() {
	if [[ -z ${REPLACING_VERSIONS} ]]; then
		elog "Some dangerous key bindings have been removed or changed to more safe values."
		elog "We enable some xterm hacks in our default screenrc, which might break some"
		elog "applications. Please check /etc/screenrc for information on these changes."
	fi

	tmpfiles_process screen.conf

	ewarn "This revision changes the screen socket location to ${EROOT}/tmp/${PN}"
}
