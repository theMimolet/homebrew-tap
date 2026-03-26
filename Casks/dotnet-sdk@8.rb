cask "dotnet-sdk-linux@8" do
  arch arm: "arm64", intel: "x64"

  version "8.0.419"
  sha256  arm:    "621987efbf2478be17f1e3b73bf81f65997803ed6094115dd64c9757f2d424b0",
          intel:  "41951b4e933fe115bd3432a5cd09bdcb3695e513863e4dc1e4f77963c7867b00"

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