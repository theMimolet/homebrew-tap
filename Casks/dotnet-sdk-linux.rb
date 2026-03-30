cask "dotnet-sdk-linux" do
  arch arm: "arm64", intel: "x64"

  version "10.0.201"
  sha256  arm:    "d46273b9514a13271dd7b668758622bfb335e7630911631322c42289e84d3962",
          intel:  "ac6b0ea9aae5d96ee5c41fed1d11c1d5c6bf8d994c75389da8055bea23e44eef"

  url "https://builds.dotnet.microsoft.com/dotnet/Sdk/#{version}/dotnet-sdk-#{version}-linux-#{arch}.tar.gz"
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

  conflicts_with cask: [
    "dotnet-sdk-linux@8",
  ]

  artifact "dotnet", target: "#{HOMEBREW_PREFIX}/bin/dotnet"

  zap trash: [
    "~/.dotnet",
    "~/.nuget",
  ]
end