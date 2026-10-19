# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit go-module

DESCRIPTION="Anise Repository Development Kit Knife"
HOMEPAGE="https://github.com/macaroni-os/anise-repo-devkit"
SRC_URI="https://api.github.com/repos/macaroni-os/anise-repo-devkit/tarball/v0.2.0 -> anise-repo-devkit-0.2.0-955e0fc.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="*"
DEPEND=">=dev-lang/go-1.24.0
	
"
BDEPEND="compress? ( app-arch/upx-bin )"
IUSE="+compress"

post_src_unpack() {
	mv macaroni-os-anise-repo-devkit-* ${S}
}

src_compile() {
	custom_ldflags=(
		"-X \"github.com/macaroni-os/anise-repo-devkit/pkg/devkit.BuildTime=$(date -u '+%Y-%m-%d %H:%M:%S %Z')\""
		"-X github.com/macaroni-os/anise-repo-devkit/pkg/devkit.BuildCommit=955e0fc6952084c79ad287fef8e30d5cec7a6f0c"
		"-X github.com/macaroni-os/anise-repo-devkit/pkg/devkit.BuildGoVersion=$(go env GOVERSION)"
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
