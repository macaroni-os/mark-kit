# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Macaroni OS Artefacts Checker"
HOMEPAGE="https://github.com/geaaru/pkgs-checker"
SRC_URI="https://api.github.com/repos/geaaru/pkgs-checker/tarball/v0.16.0 -> pkgs-checker-0.16.0.tar.gz"

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
		"-X github.com/geaaru/pkgs-checker/cmd.BuildCommit=5a4961c2a4a33066d8945867b4e6ca0e04632cf6"
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
