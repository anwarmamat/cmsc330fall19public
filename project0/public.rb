require "open3"
require "minitest/autorun"

#
# Constants
#

VERSION = /(\d+(\.\d+){,2})/
OCAML_VERSION = '4.07'

#
# Required Packages
#

class PublicTests < Minitest::Test
	def test_public_ocaml
		assert(ocaml_version, not_installed("OCaml"))
		assert_equal(true, ocaml_version.include?(OCAML_VERSION), wrong_version("OCaml"))
	end

	def test_public_opam
		assert(opam_version, not_installed("OPAM"))
	end

	def test_public_rust
		assert(rust_version, not_installed("Rust"))
	end

	def test_public_cargo
		assert(cargo_version, not_installed("Cargo"))
	end

	def test_public_sqlite3
		assert(sqlite3_version, not_installed("SQLite3"))
	end

	def test_public_ruby_gems
		assert(gem_version("minitest"), not_installed("MiniTest gem"))
		assert(gem_version("sinatra"), not_installed("Sinatra gem"))
		assert(gem_version("sqlite3"), not_installed("SQLite3 gem"))
	end

	def test_public_ocaml_pkgs
		assert(ocaml_pkg_installed("ounit"), not_installed("OUnit pkg"))
		assert(ocaml_pkg_installed("ocamlfind"), not_installed("OCamlFind pkg"))
		assert(ocaml_pkg_installed("dune"), not_installed("dune pkg"))
		assert(ocaml_pkg_installed("qcheck"), not_installed("qcheck pkg"))
	end
end

#
# Helpers
#

def not_installed(name)
	"#{name} is not installed"
end

def wrong_version(name)
	"The wrong version of #{name} is installed"
end

def optional_warn(msg)
	puts "OPTIONAL: #{msg}"
end

def match_version(cmd)
	stdout, stderr, _ = Open3.capture3(cmd)
	(stdout =~ VERSION or stderr =~ VERSION) and $1
end

#
# Version Checkers
#

def ocaml_version
	match_version("ocaml -version")
end

def opam_version
	match_version("opam --version")
end

def graphviz_version
	match_version("dot -V")
end

def rust_version
	match_version("rustc -V")
end

def cargo_version
	match_version("cargo -V")
end

def sqlite3_version
	match_version("sqlite3 -version")
end

def gem_version(name)
	spec = Gem::Specification.find { |s| s.name == name }
	spec and spec.version.version
end

def ocaml_pkg_installed(name)
	`opam list --installed #{name}`.encode("UTF-8", "UTF-8") =~ /^#{name}/
end

#
# Optional Warnings
#

if not graphviz_version
	optional_warn(not_installed("Graphviz"))
end

if not ocaml_pkg_installed "utop"
	optional_warn(not_installed("utop"))
end
