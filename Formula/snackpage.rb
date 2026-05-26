class Snackpage < Formula
  desc "Personal bookmark datastore with a keyboard-driven picker"
  homepage "https://github.com/drewvanstone/snackpage"
  # NOTE: Local testing URL. Before pushing this tap to GitHub, change to:
  #   url "https://github.com/drewvanstone/snackpage/archive/v1.7.1.tar.gz"
  # The sha256 stays the same — `git archive` is deterministic for a given tag.
  url "file:///tmp/snackpage-1.7.1.tar.gz"
  version "1.7.1"
  sha256 "43a22d1a488bc3638b00b17c9ddccde2353d9e49220ded48850ac734f0c112da"
  license "MIT"
  head "file:///Users/dflower/Code/personal/snackpage", using: :git, branch: "main"

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
