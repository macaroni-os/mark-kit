# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Macaroni OS Anise Portage Converter"
HOMEPAGE="https://github.com/macaroni-os/anise-portage-converter"
SRC_URI="https://api.github.com/repos/macaroni-os/anise-portage-converter/tarball/v0.16.3 -> anise-portage-converter-0.16.3.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="*"

DEPEND="dev-lang/go"

post_src_unpack() {
	mv macaroni-os-anise-portage-converter-* ${S}
}

src_compile() {
	custom_ldflags=(
		"-X \"github.com/macaroni-os/anise-portage-converter/pkg/converter.BuildTime=$(date -u '+%Y-%m-%d %I:%M:%S %Z')\""
		"-X github.com/macaroni-os/anise-portage-converter/pkg/converter.BuildCommit=84c731d98bf6a0d322404972b24333f661c851be"
		"-X github.com/macaroni-os/anise-portage-converter/pkg/converter.BuildGoVersion=$(go env GOVERSION)"
	)

	CGO_ENABLED=0 go build \
		-ldflags "${custom_ldflags[*]}" \
		-o ${PN} -v -x -mod=vendor . || die
}

src_install() {
	dobin "${PN}"
	dodoc README.md
	insinto /etc
	doins "${FILESDIR}"/whip.yml
	
}

# vim: filetype=ebuild
