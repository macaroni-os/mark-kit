# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Macaroni OS Build Package/Repository Tool"
HOMEPAGE="https://github.com/geaaru/luet"
SRC_URI="https://api.github.com/repos/macaroni-os/anise/tarball/v0.42.0 -> anise-build-0.42.0-ff30c6e.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="*"

DEPEND="dev-lang/go"

post_src_unpack() {
	mv geaaru-luet-* ${S}
}

src_compile() {
	custom_ldflags=(
		"-X \"github.com/geaaru/luet/pkg/config.BuildTime=$(date -u '+%Y-%m-%d %H:%M:%S %Z')\""
		"-X github.com/geaaru/luet/pkg/config.BuildCommit=ff30c6eed7324a0df72b7a843065ae5adceb4846"
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
