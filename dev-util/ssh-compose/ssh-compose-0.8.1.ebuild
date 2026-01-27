# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit go-module

DESCRIPTION="SSH Compose Orchestrator"
HOMEPAGE="https://github.com/MottainaiCI/ssh-compose"
SRC_URI="https://api.github.com/repos/MottainaiCI/ssh-compose/tarball/v0.8.1 -> ssh-compose-0.8.1-277b9f4.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="*"
DEPEND="dev-lang/go"
BDEPEND="compress? ( app-arch/upx-bin )"
IUSE="+compress"

post_src_unpack() {
	mv MottainaiCI-ssh-compose-* ${S}
}

src_compile() {
	custom_ldflags=(
		"-X \"github.com/MottainaiCI/ssh-compose/cmd.BuildTime=$(date -u '+%Y-%m-%d %H:%M:%S %Z')\""
		"-X github.com/MottainaiCI/ssh-compose/cmd.BuildCommit=277b9f42bd5015f4c957325062b1d3fa966d329e"
		"-X github.com/MottainaiCI/ssh-compose/cmd.BuildGoVersion=$(go env GOVERSION)"
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
}

# vim: filetype=ebuild
