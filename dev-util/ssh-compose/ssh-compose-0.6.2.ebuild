# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="SSH Compose Orchestrator"
HOMEPAGE="https://github.com/MottainaiCI/ssh-compose"
SRC_URI="https://github.com/MottainaiCI/ssh-compose/tarball/d5e197e9c340159c78f286c9c40ce48f54633be1 -> ssh-compose-0.6.2-d5e197e.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="*"

DEPEND="dev-lang/go"

post_src_unpack() {
	mv MottainaiCI-ssh-compose-* ${S}
}

src_compile() {
	sshcompose_ldflags=(
		"-X \"github.com/MottainaiCI/ssh-compose/cmd.BuildTime=$(date -u '+%Y-%m-%d %I:%M:%S %Z')\""
		"-X github.com/MottainaiCI/ssh-compose/cmd.BuildCommit=d5e197e9c340159c78f286c9c40ce48f54633be1"
		"-X github.com/MottainaiCI/ssh-compose/cmd.BuildGoVersion=$(go env GOVERSION)"
	)

	CGO_ENABLED=0 go build \
		-ldflags "${sshcompose_ldflags[*]}" \
		-o ${PN} -v -x -mod=vendor . || die
}

src_install() {
	dobin "${PN}"
	dodoc README.md
}

# vim: filetype=ebuild