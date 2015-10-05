# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="A hypermedia distribution protocol"
HOMEPAGE="https://ipfs.io"
SRC_URI="https://github.com/ipfs/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=dev-lang/go-1.4:="
RDEPEND=""

GO_PN=github.com/ipfs/${PN}
S=${WORKDIR}

src_unpack() {
	default_src_unpack
	mkdir -p src/${GO_PN%/*} || die
	mv ${P} src/${GO_PN} || die
}

src_compile() {
	cp -sR /usr/lib/go goroot || die
	rm -rf goroot/src/${GO_PN} || die
	rm -rf goroot/pkg/linux_${ARCH}/${GO_PN} || die
	GOROOT=${WORKDIR}/goroot GOPATH=${WORKDIR}:${WORKDIR}/cmd/ipfs \
		go install -x ${GO_PN}/cmd/ipfs || die
}

src_install() {
	insopts -m0644 -p # preserve timestamps for bug 551486
	dobin  bin/ipfs
	insinto /usr/lib/go
	doins -r pkg
	insinto /usr/lib/go/src
	find src/${GO_PN} -name .gitignore -delete
	doins -r src/*
}
