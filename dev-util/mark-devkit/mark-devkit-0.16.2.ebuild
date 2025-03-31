# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION=""
HOMEPAGE=""
SRC_URI="https://api.github.com/repos/macaroni-os/mark-devkit/tarball/v0.16.2 -> mark-devkit-0.16.2.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="*"

DEPEND="dev-lang/go"

post_src_unpack() {
	mv macaroni-os-mark-devkit-* ${S}
}

src_compile() {
	custom_ldflags=(
		"-X \"github.com/macaroni-os/mark-devkit/.BuildTime=$(date -u '+%Y-%m-%d %I:%M:%S %Z')\""
		"-X github.com/macaroni-os/mark-devkit/.BuildCommit=007b9152b6e87aeb1373e15c16898e500d2c0fce"
		"-X github.com/macaroni-os/mark-devkit/.BuildGoVersion=$(go env GOVERSION)"
	)

	CGO_ENABLED=0 go build \
		-ldflags "${custom_ldflags[*]}" \
		-o ${PN} -v -x -mod=vendor . || die
}

src_install() {
	dobin "${PN}"
}

# vim: filetype=ebuild
