class Sigil < Formula
  desc "Local-first memory + Hub for AI agents (MCP server)"
  homepage "https://github.com/kckylechen1/sigil"
  url "https://github.com/kckylechen1/sigil/archive/refs/tags/v0.5.2.tar.gz"
  sha256 "b3286aaf05ee3775517dc3dae6d0ef164778b5b8f3b42fdb40811d8665e238bf"
  license "AGPL-3.0"
  head "https://github.com/kckylechen1/sigil.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "build", "--release", "-p", "memory-server",
           "--target-dir", buildpath/"target"
    bin.install buildpath/"target/release/memory-server" => "sigil"
  end

  test do
    assert_match "sigil", shell_output("#{bin}/sigil --version")
  end

  def caveats
    <<~EOS
      To use Sigil with your AI agent, add to your MCP config:

        {
          "mcpServers": {
            "sigil": {
              "command": "#{HOMEBREW_PREFIX}/bin/sigil"
            }
          }
        }

      API keys (optional, for embedding + LLM features):
        export VOYAGE_API_KEY="your_key"
        export SILICONFLOW_API_KEY="your_key"
    EOS
  end
end
