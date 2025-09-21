# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit go-module

DESCRIPTION="A library and tool to modify tar flows at runtime"
HOMEPAGE="https://github.com/geaaru/tar-formers"
SRC_URI="https://api.github.com/repos/geaaru/tar-formers/tarball/v0.9.1 -> tar-formers-0.9.1-acfbae9.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="*"
DEPEND="dev-lang/go"

post_src_unpack() {
	mv geaaru-tar-formers-* ${S}
}

src_compile() {
	custom_ldflags=(
		"-X \"github.com/geaaru/tar-formers/cmd.BuildTime=$(date -u '+%Y-%m-%d %H:%M:%S %Z')\""
		"-X github.com/geaaru/tar-formers/cmd.BuildCommit=acfbae97479874a80044e8a400b08178fe1d0680"
		"-X github.com/geaaru/tar-formers/cmd.BuildGoVersion=$(go env GOVERSION)"
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
