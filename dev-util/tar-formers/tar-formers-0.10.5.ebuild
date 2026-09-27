# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit go-module

DESCRIPTION="A library and tool to modify tar flows at runtime"
HOMEPAGE="https://github.com/geaaru/tar-formers"
SRC_URI="https://api.github.com/repos/geaaru/tar-formers/tarball/v0.10.5 -> tar-formers-0.10.5-0980b37.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="*"
DEPEND="dev-lang/go"
BDEPEND="compress? ( app-arch/upx-bin )"
IUSE="+compress"

post_src_unpack() {
	mv geaaru-tar-formers-* ${S}
}

src_compile() {
	custom_ldflags=(
		"-X \"github.com/geaaru/tar-formers/cmd.BuildTime=$(date -u '+%Y-%m-%d %H:%M:%S %Z')\""
		"-X github.com/geaaru/tar-formers/cmd.BuildCommit=0980b37645b41f732144af9849e2c862d7b242d1"
		"-X github.com/geaaru/tar-formers/cmd.BuildGoVersion=$(go env GOVERSION)"
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
