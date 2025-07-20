# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Macaroni OS Whip tool"
HOMEPAGE="https://github.com/macaroni-os/whip"
SRC_URI="https://api.github.com/repos/macaroni-os/whip/tarball/v0.0.3 -> whip-0.0.3.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="*"

DEPEND="dev-lang/go"

post_src_unpack() {
	mv macaroni-os-whip-* ${S}
}

src_compile() {
	custom_ldflags=(
		"-X \"github.com/macaroni-os/whip/cmd.BuildTime=$(date -u '+%Y-%m-%d %I:%M:%S %Z')\""
		"-X github.com/macaroni-os/whip/cmd.BuildCommit=14f38f78f3b0e75cab85295b29421a790cd6b506"
		"-X github.com/macaroni-os/whip/cmd.BuildGoVersion=$(go env GOVERSION)"
	)

	CGO_ENABLED=0 go build \
		-ldflags "${custom_ldflags[*]}" \
		-o ${PN} -v -x -mod=vendor . || die
}

src_install() {
	dobin "${PN}"
	dodoc README.md
	insinto /etc
	doins "${FILESDIR}"/whip.yml
	
}

# vim: filetype=ebuild
