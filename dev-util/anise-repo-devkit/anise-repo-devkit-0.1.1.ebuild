# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Anise Repository Development Kit Knife"
HOMEPAGE="https://github.com/macaroni-os/anise-repo-devkit"
SRC_URI="https://api.github.com/repos/macaroni-os/anise-repo-devkit/tarball/v0.1.1 -> anise-repo-devkit-0.1.1-72ff33f.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="*"
DEPEND=">=dev-lang/go-1.24.0
	
"

post_src_unpack() {
	mv macaroni-os-anise-repo-devkit-* ${S}
}

src_compile() {
	custom_ldflags=(
		"-X \"github.com/macaroni-os/anise-repo-devkit/pkg/devkit.BuildTime=$(date -u '+%Y-%m-%d %H:%M:%S %Z')\""
		"-X github.com/macaroni-os/anise-repo-devkit/pkg/devkit.BuildCommit=72ff33f84ab8f65b648dc0514c2b52a7b1907bea"
		"-X github.com/macaroni-os/anise-repo-devkit/pkg/devkit.BuildGoVersion=$(go env GOVERSION)"
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
