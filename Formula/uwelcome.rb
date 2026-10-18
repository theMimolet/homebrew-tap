class Uwelcome < Formula
  desc "Configurable CLI Banner for your favorite Linux systems"
  homepage "https://github.com/projectbluefin/uwelcome"
  url "https://github.com/projectbluefin/uwelcome/archive/refs/tags/v0.4.2.tar.gz"
  sha256 "c11ecd404b1ca874b8d4b1109a2f3354f493f017ea6d216f04274937267b8b98"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "go" => :build

  def install
    # Read the module path from go.mod rather than hardcoding it
    go_module = File.read(buildpath/"go.mod")[/^module\s+(\S+)/, 1]
    odie "could not read module path from go.mod" if go_module.blank?
    system "go", "build", *std_go_args(ldflags: "-X #{go_module}.version=#{version}")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/uwelcome version")
  end
end