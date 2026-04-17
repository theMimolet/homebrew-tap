cask "dotnet-sdk-linux" do
  version "10.0.202"

  on_arm do
    sha256 "b8ad135d7d973c770f257f9a5b50b1c1930ae55afdd5bb3add6d2e2a10478126"

    url "https://builds.dotnet.microsoft.com/dotnet/Sdk/#{version}/dotnet-sdk-#{version}-linux-arm64.tar.gz"
  end
  on_intel do
    sha256 "61afee785a33843b9991788076eb96c9078d3884ba49b65a2a6426f3d0adb061"

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
