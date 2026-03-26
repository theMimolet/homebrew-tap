cask "dotnet-sdk" do
  arch arm: "arm64", intel: "x64"

  version "10.0.201"
  sha256 arm:   "0443386286ec778c4271a49b1447f7573d642e159717ad5033e24b14d6ce3d5c",
         intel: "d853fbdd308b13e623eae07072027cc6254ddd429f647ff7ac841c0a44d844ab"

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
    "dotnet-sdk@8",
  ]

  # tar.gz doesn't use pkg — manually stage the binary
  artifact "dotnet", target: "#{HOMEBREW_PREFIX}/bin/dotnet"

  zap trash: [
    "~/.dotnet",
    "~/.nuget",
  ]
end