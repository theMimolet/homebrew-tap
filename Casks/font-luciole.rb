cask "font-luciole" do
  version :latest
  sha256 :no_check

  url "https://luciole-vision.com/fonts/Luciole.zip",
      verified:  "luciole-vision.com"
  name "Luciole"
  homepage "https://luciole-vision.com/en/index.html"

  font "Luciole-Regular.ttf"
  font "Luciole-Regular-Italic.ttf"
  font "Luciole-Bold.ttf"
  font "Luciole-Bold-Italic.ttf"
end