# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="M.A.R.K. Development Kit Knife"
HOMEPAGE="https://github.com/macaroni-os/mark-devkit"
SRC_URI="https://api.github.com/repos/macaroni-os/mark-devkit/tarball/v0.15.1 -> mark-devkit-0.15.1.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="*"

DEPEND="dev-lang/go"

post_src_unpack() {
	mv macaroni-os-mark-devkit-* ${S}
}

src_compile() {
	custom_ldflags=(
		"-X \"github.com/macaroni-os/mark-devkit/pkg/config.BuildTime=$(date -u '+%Y-%m-%d %I:%M:%S %Z')\""
		"-X github.com/macaroni-os/mark-devkit/pkg/config.BuildCommit=969d9d601e629925c811205a3edb07011c055865"
		"-X github.com/macaroni-os/mark-devkit/pkg/config.BuildGoVersion=$(go env GOVERSION)"
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
