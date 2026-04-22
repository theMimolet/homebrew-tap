cask "dotnet-sdk-linux" do
  version "10.0.203"

  on_arm do
    sha256 "1ce569940a7d7718df6702e0628e70183ea8a839f56902a8a2c700865c584bcc"

    url "https://builds.dotnet.microsoft.com/dotnet/Sdk/#{version}/dotnet-sdk-#{version}-linux-arm64.tar.gz"
  end
  on_intel do
    sha256 "434e109c604c55e45f4d317957b4e2f093ee19ceeccdb7f880b97bdf5b96fa32"

    url "https://builds.dotnet.microsoft.com/dotnet/Sdk/#{version}/dotnet-sdk-#{version}-linux-x64.tar.gz"
  end

  name ".NET SDK"
  desc "Developer platform"
  homepage "https://www.microsoft.com/net/core#linux"

  livecheck do
    url "https://builds.dotnet.microsoft.com/dotnet/release-metadata/#{version.major_minor}/releases.json"
    regex(/^v?(\d+(?:\.\d+)+)$/i)
    strategy :json do |json, regex|
      json["releases"]&.map do |release|
        v = release.dig("sdk", "version")
        next unless v&.match(regex)

        v
      end
    end
  end

  conflicts_with cask: "dotnet-sdk-linux@8"

  binary "dotnet"

  zap trash: [
    "~/.dotnet",
    "~/.nuget",
  ]
end
