# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Macaroni OS Knife"
HOMEPAGE="https://github.com/macaroni-os/macaronictl"
SRC_URI="https://api.github.com/repos/macaroni-os/macaronictl/tarball/v0.10.0 -> macaronictl-0.10.0.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="*"

DEPEND="dev-lang/go"

post_src_unpack() {
	mv macaroni-os-macaronictl-* ${S}
}

src_compile() {
	custom_ldflags=(
		"-X \"github.com/macaroni-os/macaronictl/cmd.BuildTime=$(date -u '+%Y-%m-%d %I:%M:%S %Z')\""
		"-X github.com/macaroni-os/macaronictl/cmd.BuildCommit=395adeae819ca9e1342f76c2c7f62d2afa64de0f"
		"-X github.com/macaroni-os/macaronictl/cmd.BuildGoVersion=$(go env GOVERSION)"
	)

	CGO_ENABLED=0 go build \
		-ldflags "${custom_ldflags[*]}" \
		-o ${PN} -v -x -mod=vendor . || die
}

src_install() {
	dobin "${PN}"
	dodoc README.md
}

# vim: filetype=ebuild
