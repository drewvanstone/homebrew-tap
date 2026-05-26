class Snackpage < Formula
  desc "Personal bookmark datastore with a keyboard-driven picker"
  homepage "https://github.com/drewvanstone/snackpage"
  url "https://github.com/drewvanstone/snackpage/archive/refs/tags/v1.8.1.tar.gz"
  version "1.8.1"
  sha256 "011dc188a9268a6b61e6a17226cf728c88bf7b5471b8cb1bdf9d58d0af08b7da"
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

  test do
    output = shell_output("#{bin}/snackpage version")
    assert_match "snackpage", output
  end
end
