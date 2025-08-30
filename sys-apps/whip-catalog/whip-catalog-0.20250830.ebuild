# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Whip tool Catalog"
HOMEPAGE="https://github.com/macaroni-os/whip-catalog"
SRC_URI="https://api.github.com/repos/macaroni-os/whip-catalog/tarball/refs/tags/v0.20250830 -> whip-catalog-0.20250830-7178351.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="*"
RDEPEND="
	app-admin/whip
	
"

post_src_unpack() {
	mv macaroni-os-whip-catalog-* ${S}
}

src_install() {
	insinto /usr/share/macaroni/whip-catalog/eclass
	for f in "${S}"/catalog/eclass/*.yaml ; do
	  doins "${f}"
	done
	insinto /usr/share/macaroni/whip-catalog/commons
	for f in "${S}"/catalog/commons/*.yaml ; do
	  doins "${f}"
	done
}



# vim: filetype=ebuild
