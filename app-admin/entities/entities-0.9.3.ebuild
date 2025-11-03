# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit go-module

DESCRIPTION="Macaroni OS Anise System Users/Groups Manager"
HOMEPAGE="https://github.com/geaaru/entities"
SRC_URI="https://api.github.com/repos/geaaru/entities/tarball/v0.9.3-geaaru -> entities-0.9.3-35b678e.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="*"
DEPEND="dev-lang/go"

post_src_unpack() {
	mv geaaru-entities-* ${S}
}

src_compile() {
	custom_ldflags=(
		"-X \"github.com/geaaru/entities/cmd.BuildTime=$(date -u '+%Y-%m-%d %H:%M:%S %Z')\""
		"-X github.com/geaaru/entities/cmd.BuildCommit=35b678ed64e1cc9efd46d7c16c17532fcb40712c"
		"-X github.com/geaaru/entities/cmd.BuildGoVersion=$(go env GOVERSION)"
	)

	CGO_ENABLED=0 go build \
		-ldflags "${custom_ldflags[*]}" \
		-o ${PN} -v -x -mod=vendor . || die
}

src_install() {
	dobin "${PN}"
	dodoc README.md
}

# vim: filetype=ebuild
