cask "font-luciole-math" do
    version :latest
    sha256 :no_check

    url "https://luciole-vision.com/fonts/Luciole-Math.zip",
        verified:  "luciole-vision.com"
    name "Luciole Math"
    homepage "https://luciole-vision.com/en/math.html"

    font "Luciole-Math.otf"
end