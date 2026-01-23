# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit go-module

DESCRIPTION="Deploy a complex environment to an LXD Cluster or LXD standalone installation"
HOMEPAGE="https://github.com/MottainaiCI/lxd-compose"
SRC_URI="https://api.github.com/repos/MottainaiCI/lxd-compose/tarball/v0.37.1 -> lxd-compose-0.37.1-b6f55ca.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="*"
DEPEND="dev-lang/go"
BDEPEND="compress? ( app-arch/upx-bin )"
IUSE="+compress"

post_src_unpack() {
	mv MottainaiCI-lxd-compose-* ${S}
}

src_compile() {
	custom_ldflags=(
		"-X \"github.com/MottainaiCI/lxd-compose/cmd.BuildTime=$(date -u '+%Y-%m-%d %H:%M:%S %Z')\""
		"-X github.com/MottainaiCI/lxd-compose/cmd.BuildCommit=b6f55ca904c775ea56db5b1e613c3b2f7fd81817"
		"-X github.com/MottainaiCI/lxd-compose/cmd.BuildGoVersion=$(go env GOVERSION)"
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
