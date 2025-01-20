# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Macaroni OS Package Manager System"
HOMEPAGE="https://github.com/geaaru/luet"
SRC_URI="https://api.github.com/repos/geaaru/luet/tarball/v0.41.1-geaaru -> anise-0.41.1.tar.gz"

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
		-o ${PN} \
		-v -x -mod=vendor . || die
}
src_install() {

	dobin "anise"
	dosym /usr/bin/${PN} /usr/bin/luet
	dodoc README.md
	
	dosym /etc/anise /etc/luet
	insinto /etc/anise
	newins "${FILESDIR}"/anise.yaml anise.yaml
	dosym /etc/anise/anise.yaml /etc/anise/luet.yaml
	
	insinto /etc/anise/repos.conf.d
	newins "${FILESDIR}"/geaaru-repo-index.yml geaaru-repo-index.yml
	
}

# vim: filetype=ebuild
