cask "nokkvi-macos" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.31.0-macos.1"
  sha256 arm:   "0000000000000000000000000000000000000000000000000000000000000000",
         intel: "0000000000000000000000000000000000000000000000000000000000000000"

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
