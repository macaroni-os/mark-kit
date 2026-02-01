# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit go-module

DESCRIPTION="Macaroni OS Knife"
HOMEPAGE="https://github.com/macaroni-os/macaronictl"
SRC_URI="https://api.github.com/repos/macaroni-os/macaronictl/tarball/v0.10.1 -> macaronictl-0.10.1-8b615b7.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="*"
DEPEND="dev-lang/go"

post_src_unpack() {
	mv macaroni-os-macaronictl-* ${S}
}

src_compile() {
	custom_ldflags=(
		"-X \"github.com/macaroni-os/macaronictl/cmd.BuildTime=$(date -u '+%Y-%m-%d %H:%M:%S %Z')\""
		"-X github.com/macaroni-os/macaronictl/cmd.BuildCommit=8b615b788e9771fc6d6d9f65368dfe748617fe0b"
		"-X github.com/macaroni-os/macaronictl/cmd.BuildGoVersion=$(go env GOVERSION)"
	)

	CGO_ENABLED=0 go build \
		-ldflags "${custom_ldflags[*]}" \
		-o ${PN} -v -x -mod=vendor . || die
}

src_install() {
	dobin "${PN}"
	dodoc README.md
	insinto /usr/share/macaroni/browsers/
	newins "${S}"/contrib/browsers-catalog/macaroni.yml catalog
	insinto /etc/macaroni/kernels-profiles/
	doins "${S}"/contrib/kernel-profiles/debian.yml
	doins "${S}"/contrib/kernel-profiles/macaroni.yml
	doins "${S}"/contrib/kernel-profiles/macaroni-zen.yml
	
}

# vim: filetype=ebuild
