cask "dotnet-sdk@8" do
  arch arm: "arm64", intel: "x64"

  version "8.0.419"
  sha256 arm:   "ab4345de059d1dd88c1d940d996240ff5565ba1816e085a1085013164cba59b6",
         intel: "48d65a2bafe55f718b4d4c28bcdf27540ccafa7ffcd213fe4b91c17b3121815f"

  url "https://builds.dotnet.microsoft.com/dotnet/Sdk/#{version}/dotnet-sdk-#{version}-linux-#{arch}.tar.gz"
  name ".NET SDK 8"
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

  artifact "dotnet", target: "#{HOMEBREW_PREFIX}/bin/dotnet"

  zap trash: [
    "~/.dotnet",
    "~/.nuget",
  ]
end