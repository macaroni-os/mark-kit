# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Macaroni OS Package Manager System"
HOMEPAGE="https://github.com/macaroni-os/anise"
SRC_URI="https://api.github.com/repos/macaroni-os/anise/tarball/v0.45.4 -> anise-0.45.4-d0eaa66.tar.gz"

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
		"-X github.com/macaroni-os/anise/pkg/config.BuildCommit=d0eaa6640a93a36e3f55d577b47e506253c98ab0"
		"-X github.com/macaroni-os/anise/pkg/config.BuildGoVersion=$(go env GOVERSION)"
	)

	CGO_ENABLED=0 go build \
		-ldflags "${custom_ldflags[*]}" \
		-o ${PN} \
		-v -x -mod=vendor . || die
}
src_install() {

	dobin "anise"
	dodoc README.md
	
	insinto /etc/anise
	newins "${FILESDIR}"/anise.yaml anise.yaml
	
	insinto /etc/anise/repos.conf.d
	newins "${FILESDIR}"/macaroni-repo-index.yml macaroni-repo-index.yml
	
}

# vim: filetype=ebuild
