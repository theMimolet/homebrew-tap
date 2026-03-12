cask "font-luciole" do
    version :latest
    sha256 :no_check

    url "https://luciole-vision.com/fonts/Luciole.zip",
        verified:  "luciole-vision.com"
    name "Luciole"
    homepage "https://luciole-vision.com/en/index.html"

    font "Luciole/Luciole-Regular.ttf"
    font "Luciole/Luciole-Regular-Italic.ttf"
    font "Luciole/Luciole-Bold.ttf"
    font "Luciole/Luciole-Bold-Italic.ttf"
end