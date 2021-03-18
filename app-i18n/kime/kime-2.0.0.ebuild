# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo cmake xdg-utils gnome2-utils qmake-utils desktop

CRATES="
ahash-0.7.2
ansi_term-0.11.0
ansi_term-0.12.1
anyhow-1.0.38
array-macro-1.0.5
atty-0.2.14
autocfg-1.0.1
bindgen-0.57.0
bitflags-1.2.1
cairo-rs-0.9.1
cairo-sys-rs-0.10.0
cbindgen-0.18.0
cc-1.0.67
cexpr-0.4.0
cfg-if-1.0.0
chrono-0.4.19
clang-sys-1.1.1
clap-2.33.3
cty-0.2.1
darling-0.12.2
darling_core-0.12.2
darling_macro-0.12.2
dbus-0.9.2
dbus-codegen-0.9.1
dbus-tree-0.9.0
downcast-rs-1.2.0
dtoa-0.4.7
either-1.6.1
enum-map-0.6.4
enum-map-derive-0.4.6
enumset-1.0.6
enumset_derive-0.5.4
fnv-1.0.7
form_urlencoded-1.0.1
futures-channel-0.3.13
futures-core-0.3.13
futures-executor-0.3.13
futures-macro-0.3.13
futures-task-0.3.13
futures-util-0.3.13
gethostname-0.2.1
getrandom-0.2.2
git2-0.13.17
glib-0.10.3
glib-macros-0.10.1
glib-sys-0.10.1
glob-0.3.0
gobject-sys-0.10.0
hashbrown-0.9.1
heck-0.3.2
hermit-abi-0.1.18
ident_case-1.0.1
idna-0.2.2
indexmap-1.6.2
itertools-0.9.0
itertools-0.10.0
itoa-0.4.7
jobserver-0.1.21
ksni-0.1.2
lazy_static-1.4.0
lazycell-1.3.0
libc-0.2.89
libdbus-sys-0.2.1
libgit2-sys-0.12.18+1.1.0
libz-sys-1.1.2
linked-hash-map-0.5.4
log-0.4.14
maplit-1.0.2
matches-0.1.8
memchr-2.3.4
mio-0.7.10
mio-timerfd-0.2.0
miow-0.3.6
nix-0.20.0
nom-5.1.2
ntapi-0.3.6
num-derive-0.3.3
num-integer-0.1.44
num-traits-0.2.14
once_cell-1.7.2
pad-0.1.6
peeking_take_while-0.1.2
percent-encoding-2.1.0
pico-args-0.4.0
pin-project-lite-0.2.6
pin-utils-0.1.0
pkg-config-0.3.19
ppv-lite86-0.2.10
proc-macro-crate-0.1.5
proc-macro-error-1.0.4
proc-macro-error-attr-1.0.4
proc-macro-hack-0.5.19
proc-macro-nested-0.1.7
proc-macro2-1.0.24
quick-xml-0.22.0
quote-1.0.9
rand-0.8.3
rand_chacha-0.3.0
rand_core-0.6.2
rand_hc-0.3.0
redox_syscall-0.2.5
regex-1.4.5
regex-syntax-0.6.23
remove_dir_all-0.5.3
rustc-hash-1.1.0
ryu-1.0.5
serde-1.0.124
serde_derive-1.0.124
serde_json-1.0.64
serde_yaml-0.8.17
shadow-rs-0.5.24
shlex-0.1.1
simplelog-0.9.0
slab-0.4.2
smallvec-1.6.1
socket2-0.3.19
strsim-0.8.0
strsim-0.10.0
strum-0.18.0
strum-0.20.0
strum_macros-0.18.0
strum_macros-0.20.1
syn-1.0.64
system-deps-1.3.2
tempfile-3.2.0
termcolor-1.1.2
textwrap-0.11.0
thiserror-1.0.24
thiserror-impl-1.0.24
time-0.1.43
tinyvec-1.1.1
tinyvec_macros-0.1.0
toml-0.5.8
unicode-bidi-0.3.4
unicode-normalization-0.1.17
unicode-segmentation-1.7.1
unicode-width-0.1.8
unicode-xid-0.2.1
url-2.2.1
vcpkg-0.2.11
vec_map-0.8.2
version-compare-0.0.10
version_check-0.9.3
wasi-0.10.2+wasi-snapshot-preview1
wayland-client-0.28.5
wayland-commons-0.28.5
wayland-protocols-0.28.5
wayland-scanner-0.28.5
wayland-sys-0.28.5
winapi-0.3.9
winapi-i686-pc-windows-gnu-0.4.0
winapi-util-0.1.5
winapi-wsapoll-0.1.1
winapi-x86_64-pc-windows-gnu-0.4.0
x11rb-0.8.1
xdg-2.2.0
xim-0.1.0
xim-ctext-0.1.0
xim-parser-0.1.0
xml-rs-0.8.3
yaml-rust-0.4.5
zwp-virtual-keyboard-0.2.2
"

DESCRIPTION="Korean IME"
HOMEPAGE="https://github.com/Riey/kime"
SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz $(cargo_crate_uris ${CRATES})"
RESTRICT="mirror"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm64 ~arm ~hppa ~ppc ~ppc64"

IUSE="
	X
	+check
	+indicator
	gtk
	gtk2
	qt
	wayland
"
DEPEND="
	X? (
		x11-libs/libxcb
		x11-libs/cairo
	)
	indicator? (
		sys-apps/dbus
	)
	gtk? ( x11-libs/gtk+:3 )
	gtk2? ( x11-libs/gtk+:2 )
	qt? ( dev-qt/qtgui )
"
RDEPEND="${DEPEND}"
BDEPEND="

"
CMAKE_USE_DIR="${S}/src"
BUILD_DIR="${WORKDIR}/${P}_build"
QA_SONAME=(
	"usr/lib/libkime_engine.so"
	"usr/lib64/libkime_engine.so"
)

src_unpack() {
	cargo_src_unpack
	default
}

src_configure() {
	local mycmakeargs=()

	if (use gtk); then
		mycmakeargs+=(-DENABLE_GTK3=ON)
	fi

	if (use gtk2); then
		mycmakeargs+=(-DENABLE_GTK2=ON)
	fi

	if (use qt); then
		mycmakeargs+=(-DENABLE_QT5=ON)
	fi

	cmake_src_configure || die
}

src_compile() {
	local cargopkgs=(-pkime-engine-capi -pkime-engine-cffi)
	if (use X); then
		cargopkgs+=(-pkime-xim)
	fi
	if (use wayland); then
		cargopkgs+=(-pkime-wayland)
	fi
	if (use check); then
		cargopkgs+=(-pkime-check)
	fi
	if (use indicator); then
		cargopkgs+=(-pkime-indicator)
	fi
	cargo_src_compile "${cargopkgs[@]}" || die
	cmake_src_compile || die
}

src_install() {
	dolib.so target/release/libkime_engine.so

	if (use X); then
		dobin target/release/kime-xim
		domenu res/kime-xim.desktop
	fi

	if (use wayland); then
		dobin target/release/kime-wayland
		domenu res/kime-wayland.desktop
	fi

	if (use check); then
		dobin target/release/kime-check
	fi

	if (use indicator); then
		dobin target/release/kime-indicator
		domenu res/kime-indicator.desktop
	fi

	insopts -m0644
	insinto /etc/xdg/kime
	newins res/default_config.yaml config.yaml

	doicon -s 64x64 res/icons/64x64/*

	insopts -m0755

	if (use gtk); then
		insinto "/usr/$(get_libdir)/gtk-3.0/3.0.0/immodules"
		newins "${BUILD_DIR}/lib/libkime-gtk3.so" "im-kime.so"
	fi

	if (use gtk2); then
		insinto "/usr/$(get_libdir)/gtk-2.0/2.10.0/immodules"
		newins "${BUILD_DIR}/lib/libkime-gtk2.so" "im-kime.so"
	fi

	if (use qt); then
		insinto "/$(qt5_get_plugindir)/platforminputcontexts"
		newins "${BUILD_DIR}/lib/libkime-qt5.so" "libkimeplatforminputcontextplugin.so"
	fi
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
	use gtk && gnome2_query_immodules_gtk3
	use gtk2 && gnome2_query_immodules_gtk2
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
	use gtk && gnome2_query_immodules_gtk3
	use gtk2 && gnome2_query_immodules_gtk2
}

