# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit go-module

DESCRIPTION="Macaroni OS Artefacts Checker"
HOMEPAGE="https://github.com/geaaru/pkgs-checker"
SRC_URI="https://api.github.com/repos/geaaru/pkgs-checker/tarball/v0.17.0 -> pkgs-checker-0.17.0-bf74b57.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="*"
DEPEND="dev-lang/go"

post_src_unpack() {
	mv geaaru-pkgs-checker-* ${S}
}

src_compile() {
	custom_ldflags=(
		"-X \"github.com/geaaru/pkgs-checker/cmd.BuildTime=$(date -u '+%Y-%m-%d %H:%M:%S %Z')\""
		"-X github.com/geaaru/pkgs-checker/cmd.BuildCommit=bf74b578f40d3695a3d0c3126106de7ca237a205"
		"-X github.com/geaaru/pkgs-checker/cmd.BuildGoVersion=$(go env GOVERSION)"
	)

	CGO_ENABLED=0 go build \
		-ldflags "${custom_ldflags[*]}" \
		-o ${PN} -v -x -mod=vendor . || die
}

src_install() {
	dobin "${PN}"
	dodoc README.md
	insinto /usr/share/pkgs-checker
	doins "${S}"/contrib/gen-uses-filter.yaml
	
}

# vim: filetype=ebuild
