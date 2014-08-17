# Distributed under the terms of the GNU General Public License v2

EAPI="5"

inherit base eutils

DESCRIPTION="Library for import of FreeHand drawings"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/libfreehand/"
SRC_URI="http://dev-www.libreoffice.org/src/${PN}/${P}.tar.xz"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~*"
IUSE="doc static-libs"

RDEPEND="
	app-text/libwpd:0.9
	app-text/libwpg:0.2
	dev-libs/librevenge
	sys-libs/zlib
"
DEPEND="${RDEPEND}
	dev-util/gperf
	sys-devel/libtool
	virtual/pkgconfig
	doc? ( app-doc/doxygen )
"

RESTRICT="mirror"

src_prepare() {
	[[ -d m4 ]] || mkdir "m4"
	base_src_prepare
}

src_configure() {
	econf \
		--docdir="${EPREFIX}/usr/share/doc/${PF}" \
		$(use_enable static-libs static) \
		--disable-werror \
		$(use_with doc docs)
}

src_install() {
	default
	prune_libtool_files --all
}
