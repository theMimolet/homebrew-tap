class UMotd < Formula
  desc "Translatable MOTD for Universal Blue"
  homepage "https://github.com/projectbluefin/umotd"
  url "https://github.com/projectbluefin/umotd/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "a06e9ecbd373620e7be8c12c2dd5767dde912369c3e27f28db5ef8880706778f"
  license "Apache-2.0"

  livecheck do
    url "https://github.com/projectbluefin/umotd/releases/latest"
    strategy :json do |json|
      json["tag_name"]&.delete("v")
    end
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags:)
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/umotd version")
  end
end