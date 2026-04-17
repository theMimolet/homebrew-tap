cask "dotnet-sdk-linux@8" do
  version "8.0.420"

  on_arm do
    sha256 "f1e12e7d633393054b6431046dcb01f2cfe4c5ccff234f730f0c3f7f8706bc42"

    url "https://builds.dotnet.microsoft.com/dotnet/Sdk/#{version}/dotnet-sdk-#{version}-linux-arm64.tar.gz"
  end
  on_intel do
    sha256 "7e3c39f54e6412a807df3e8e59ff3338a3a4c4923db35f6164808586535071c3"

    url "https://builds.dotnet.microsoft.com/dotnet/Sdk/#{version}/dotnet-sdk-#{version}-linux-x64.tar.gz"
  end

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

  conflicts_with cask: "dotnet-sdk-linux"

  binary "dotnet"

  zap trash: [
    "~/.dotnet",
    "~/.nuget",
  ]
end
