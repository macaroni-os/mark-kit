# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Macaroni OS Package Manager System"
HOMEPAGE="https://github.com/macaroni-os/anise"
SRC_URI="https://api.github.com/repos/macaroni-os/anise/tarball/v0.42.3 -> anise-0.42.3-d45a472.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="*"

DEPEND="dev-lang/go"

post_src_unpack() {
	mv macaroni-os-anise-* ${S}
}

src_compile() {
	custom_ldflags=(
		"-X \"github.com/macaroni-os/anise/pkg/config.BuildTime=$(date -u '+%Y-%m-%d %H:%M:%S %Z')\""
		"-X github.com/macaroni-os/anise/pkg/config.BuildCommit=d45a472f102406f70e1d729043064baafcbe6187"
		"-X github.com/macaroni-os/anise/pkg/config.BuildGoVersion=$(go env GOVERSION)"
	)

	CGO_ENABLED=0 go build \
		-ldflags "${custom_ldflags[*]}" \
		-o ${PN} \
		-v -x -mod=vendor . || die
}
src_install() {

	dobin "anise"
	dosym /usr/bin/anise /usr/bin/luet
	dodoc README.md
	
	insinto /etc/anise
	newins "${FILESDIR}"/anise.yaml anise.yaml
	
	insinto /etc/anise/repos.conf.d
	newins "${FILESDIR}"/geaaru-repo-index.yml geaaru-repo-index.yml
	
}

# vim: filetype=ebuild
