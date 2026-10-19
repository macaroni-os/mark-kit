# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit go-module

DESCRIPTION="Macaroni OS Anise Portage Converter"
HOMEPAGE="https://github.com/macaroni-os/anise-portage-converter"
SRC_URI="https://api.github.com/repos/macaroni-os/anise-portage-converter/tarball/v0.17.0 -> anise-portage-converter-0.17.0-55bedcc.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="*"
DEPEND="dev-lang/go"
BDEPEND="compress? ( app-arch/upx-bin )"
IUSE="+compress"

post_src_unpack() {
	mv macaroni-os-anise-portage-converter-* ${S}
}

src_compile() {
	custom_ldflags=(
		"-X \"github.com/macaroni-os/anise-portage-converter/pkg/converter.BuildTime=$(date -u '+%Y-%m-%d %H:%M:%S %Z')\""
		"-X github.com/macaroni-os/anise-portage-converter/pkg/converter.BuildCommit=55bedccb03d93a2cc81a33068acbd629924cdca1"
		"-X github.com/macaroni-os/anise-portage-converter/pkg/converter.BuildGoVersion=$(go env GOVERSION)"
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
