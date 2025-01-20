# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Macaroni OS GPU Configurator"
HOMEPAGE="https://github.com/macaroni-os/gpu-configurator"
SRC_URI="https://api.github.com/repos/macaroni-os/gpu-configurator/tarball/v0.2.8 -> gpu-configurator-0.2.8.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="*"

DEPEND="dev-lang/go"
RDEPEND="
	sys-apps/kmod
	sys-apps/pciutils
	
"

post_src_unpack() {
	mv macaroni-os-gpu-configurator-* ${S}
}

src_compile() {
	custom_ldflags=(
		"-X \"github.com/macaroni-os/gpu-configurator/cmd.BuildTime=$(date -u '+%Y-%m-%d %I:%M:%S %Z')\""
		"-X github.com/macaroni-os/gpu-configurator/cmd.BuildCommit=8ad2e6a25061afd81d73ee1d18500b1f9ba94690"
		"-X github.com/macaroni-os/gpu-configurator/cmd.BuildGoVersion=$(go env GOVERSION)"
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
