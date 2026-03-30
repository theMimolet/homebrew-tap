cask "dotnet-sdk-linux" do
  version "10.0.201"

  if Hardware::CPU.arm?
    sha256 "621987efbf2478be17f1e3b73bf81f65997803ed6094115dd64c9757f2d424b0"
    url "https://builds.dotnet.microsoft.com/dotnet/Sdk/#{version}/dotnet-sdk-#{version}-linux-arm64.tar.gz"
  else  # x64/intel
    sha256 "ac6b0ea9aae5d96ee5c41fed1d11c1d5c6bf8d994c75389da8055bea23e44eef"
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

  conflicts_with cask: [
    "dotnet-sdk-linux@8",
  ]

  artifact "dotnet", target: "#{HOMEBREW_PREFIX}/bin/dotnet"

  zap trash: [
    "~/.dotnet",
    "~/.nuget",
  ]
end