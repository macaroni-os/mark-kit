# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Macaroni OS - M.A.R.K. Development Kit"
HOMEPAGE="https://github.com/macaroni-os/mark-devkit"
SRC_URI="https://github.com/macaroni-os/mark-devkit/tarball/03ea15c219bc4057e5ca178b8a718f8e67b26f42 -> mark-devkit-0.9.0-03ea15c.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="*"

DEPEND="dev-lang/go"

post_src_unpack() {
	mv macaroni-os-mark-* ${S}
}

src_compile() {
	mark_ldflags=(
		"-X \"github.com/macaroni-os/mark-devkit/pkg/config.BuildTime=$(date -u '+%Y-%m-%d %I:%M:%S %Z')\""
		"-X github.com/macaroni-os/mark-devkit/pkg/config.BuildCommit=03ea15c219bc4057e5ca178b8a718f8e67b26f42"
		"-X github.com/macaroni-os/mark-devkit/pkg/config.BuildGoVersion=$(go env GOVERSION)"
	)

	CGO_ENABLED=0 go build \
		-ldflags "${mark_ldflags[*]}" \
		-o ${PN} -v -x -mod=vendor . || die
}

src_install() {
	dobin "${PN}"
	dodoc README.md
}

# vim: filetype=ebuild