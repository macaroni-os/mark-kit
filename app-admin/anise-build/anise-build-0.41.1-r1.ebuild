# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Macaroni OS Build Package/Repository Tool"
HOMEPAGE="https://github.com/geaaru/luet"
SRC_URI="https://api.github.com/repos/geaaru/luet/tarball/v0.41.1-geaaru -> anise-build-0.41.1.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="*"

DEPEND="dev-lang/go"

post_src_unpack() {
	mv geaaru-luet-* ${S}
}

src_compile() {
	custom_ldflags=(
		"-X \"github.com/geaaru/luet/pkg/config.BuildTime=$(date -u '+%Y-%m-%d %I:%M:%S %Z')\""
		"-X github.com/geaaru/luet/pkg/config.BuildCommit=c4815024d03bc88794c76a165ba4018ae07296a3"
		"-X github.com/geaaru/luet/pkg/config.BuildGoVersion=$(go env GOVERSION)"
	)

	CGO_ENABLED=0 go build \
		-ldflags "${custom_ldflags[*]}" \
		-o luet-build/${PN} \
		-v -x -mod=vendor ./luet-build/ || die
}
src_install() {

	dobin luet-build/${PN}
	dosym /usr/bin/${PN} /usr/bin/luet-build
	dodoc README.md
	
}

# vim: filetype=ebuild
