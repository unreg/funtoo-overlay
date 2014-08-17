# Distributed under the terms of the GNU General Public License v2

EAPI="5"

inherit base eutils

DESCRIPTION="Library parsing Apple Keynote presentations"
HOMEPAGE="https://wiki.documentfoundation.org/DLP/Libraries/libetonyek"
SRC_URI="http://dev-www.libreoffice.org/src/${PN}/${P}.tar.xz"

LICENSE="|| ( GPL-2+ LGPL-2.1 MPL-1.1 )"
SLOT="0"
KEYWORDS="*"
IUSE="doc static-libs test"

RDEPEND="
	app-text/libwpd:0.9
	dev-libs/boost:=
	dev-libs/libxml2
	sys-libs/zlib
"
DEPEND="${RDEPEND}
	>=dev-libs/boost-1.46
	dev-util/gperf
	sys-devel/libtool
	virtual/pkgconfig
	doc? ( app-doc/doxygen )
	test? ( dev-util/cppunit )
"

PATCHES=(
	"${FILESDIR}/${P}-comma.patch"
	"${FILESDIR}/${P}-lexical_cast.patch"
)

src_prepare() {
	[[ -d m4 ]] || mkdir "m4"
	base_src_prepare
}

src_configure() {
	econf \
		--docdir="${EPREFIX}/usr/share/doc/${PF}" \
		$(use_enable static-libs static) \
		--disable-werror \
		$(use_enable test tests) \
		$(use_with doc docs)
}

src_install() {
	default
	prune_libtool_files --all
}
