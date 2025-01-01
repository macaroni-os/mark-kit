# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Macaroni OS Artefacts Checker"
HOMEPAGE="https://github.com/geaaru/pkgs-checker"
SRC_URI="https://github.com/geaaru/pkgs-checker/tarball/0555b27d3b2170cb054022b0016285f3eb9b520b -> pkgs-checker-0.14.4-0555b27.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="*"

DEPEND="dev-lang/go"

post_src_unpack() {
	mv geaaru-pkgs-checker-* ${S}
}

src_compile() {
	anise_ldflags=(
		"-X \"github.com/geaaru/pkgs-checker/cmd.BuildTime=$(date -u '+%Y-%m-%d %I:%M:%S %Z')\""
		"-X github.com/geaaru/pkgs-checker/cmd.BuildCommit=0555b27d3b2170cb054022b0016285f3eb9b520b"
		"-X github.com/geaaru/pkgs-checker/cmd.BuildGoVersion=$(go env GOVERSION)"
	)

	CGO_ENABLED=0 go build \
		-ldflags "${anise_ldflags[*]}" \
		-o ${PN} -v -x -mod=vendor . || die
}

src_install() {
	dobin "${PN}"
	dodoc README.md
}

# vim: filetype=ebuild