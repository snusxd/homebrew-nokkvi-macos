cask "nokkvi-macos" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.32.1-macos.2"
  sha256 arm:   "7ca4185490e75cc2267be5229e5b6545ad617a43da5b01793e447d9b04122d2c",
         intel: "64969b709714086a8b1a8980d6448e79721bd4726aedd6d7c8be2195fcf6985d"

  url "https://github.com/snusxd/nokkvi-macos/releases/download/v#{version}/nokkvi-v#{version}-#{arch}-apple-darwin.zip"
  name "Nokkvi"
  desc "Native Navidrome music client (fork of nokkvi)"
  homepage "https://github.com/snusxd/nokkvi-macos"

  livecheck do
    url :url
    regex(/^v?(\d+(?:\.\d+)+-macos\.\d+)$/i)
    strategy :github_latest
  end

  # LSMinimumSystemVersion is 11.0 (Big Sur)
  depends_on :macos

  app "Nokkvi.app"
  binary "#{appdir}/Nokkvi.app/Contents/MacOS/nokkvi"

  postflight_steps do
    run "/usr/bin/xattr",
        args: ["-dr", "com.apple.quarantine", "{{appdir}}/Nokkvi.app"],
        sudo: false
  end

  zap trash: [
    "~/Library/Application Support/nokkvi",
    "~/Library/Caches/nokkvi",
    "~/Library/Saved Application State/org.nokkvi.nokkvi.savedState",
  ]

  caveats <<~EOS
    Nokkvi is ad-hoc signed and not notarized by Apple.
    The postflight hook removes the com.apple.quarantine attribute from
    #{appdir}/Nokkvi.app so macOS Gatekeeper does not block launching it.
  EOS
end
