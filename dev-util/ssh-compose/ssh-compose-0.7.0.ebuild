# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="SSH Compose Orchestrator"
HOMEPAGE="https://github.com/MottainaiCI/ssh-compose"
SRC_URI="https://api.github.com/repos/MottainaiCI/ssh-compose/tarball/v0.7.0 -> ssh-compose-0.7.0.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="*"

DEPEND="dev-lang/go"

post_src_unpack() {
	mv MottainaiCI-ssh-compose-* ${S}
}

src_compile() {
	custom_ldflags=(
		"-X \"github.com/MottainaiCI/ssh-compose/cmd.BuildTime=$(date -u '+%Y-%m-%d %H:%M:%S %Z')\""
		"-X github.com/MottainaiCI/ssh-compose/cmd.BuildCommit=9b6e638f449d18088a5cd8af16cb07a89872a382"
		"-X github.com/MottainaiCI/ssh-compose/cmd.BuildGoVersion=$(go env GOVERSION)"
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
