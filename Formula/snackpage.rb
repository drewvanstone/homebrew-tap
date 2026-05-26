class Snackpage < Formula
  desc "Personal bookmark datastore with a keyboard-driven picker"
  homepage "https://github.com/drewvanstone/snackpage"
  url "https://github.com/drewvanstone/snackpage/archive/refs/tags/v1.8.2.tar.gz"
  version "1.8.2"
  sha256 "d0cbec441f3a378fac5e290339c5890b3b3b9e336a16b7ec57a0a721fd27967b"
  license "MIT"
  head "https://github.com/drewvanstone/snackpage.git", branch: "main"

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go", "build",
           "-trimpath",
           "-ldflags", "-s -w -X main.version=#{version}",
           "-o", bin/"snackpage",
           "./cmd/snackpage"
  end

  service do
    run [opt_bin/"snackpage", "serve"]
    keep_alive true
    log_path var/"log/snackpage.log"
    error_log_path var/"log/snackpage.log"
  end

  def caveats
    <<~EOS
      To start snackpage now and on login:
        brew services start snackpage

      Then point your browser's new-tab page at:
        http://127.0.0.1:8765

      After upgrades, restart the daemon to pick up the new binary
      (Homebrew does not auto-restart services):
        brew services restart snackpage
    EOS
  end

  test do
    output = shell_output("#{bin}/snackpage version")
    assert_match "snackpage", output
  end
end
