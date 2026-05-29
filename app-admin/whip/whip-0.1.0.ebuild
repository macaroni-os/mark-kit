# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit go-module

DESCRIPTION="Macaroni OS Whip tool"
HOMEPAGE="https://github.com/macaroni-os/whip"
SRC_URI="https://api.github.com/repos/macaroni-os/whip/tarball/v0.1.0 -> whip-0.1.0-6329826.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="*"
DEPEND="dev-lang/go"
BDEPEND="compress? ( app-arch/upx-bin )"
IUSE="+compress"

post_src_unpack() {
	mv macaroni-os-whip-* ${S}
}

src_compile() {
	custom_ldflags=(
		"-X \"github.com/macaroni-os/whip/cmd.BuildTime=$(date -u '+%Y-%m-%d %H:%M:%S %Z')\""
		"-X github.com/macaroni-os/whip/cmd.BuildCommit=632982665b03e16c9271c1715ce46c851986225a"
		"-X github.com/macaroni-os/whip/cmd.BuildGoVersion=$(go env GOVERSION)"
	)

	CGO_ENABLED=0 go build \
		-ldflags "${custom_ldflags[*]}" \
		-o ${PN} -v -x -mod=vendor . || die
	if use compress ; then
		upx --brute -1 ${PN} || die
	fi
}

src_install() {
	dobin "${PN}"
	dodoc README.md
	insinto /etc
	doins "${FILESDIR}"/whip.yml
	
}

# vim: filetype=ebuild
