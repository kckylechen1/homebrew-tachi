class Tachi < Formula
  desc "Local-first memory + Hub for AI agents (MCP server)"
  homepage "https://github.com/kckylechen1/tachi"
  url "https://github.com/kckylechen1/tachi/archive/refs/tags/v0.7.2.tar.gz"
  sha256 "e50dd796cbb5c0e894a6605357fbca2eade96733f2bd8fbf2bb42424f8f3b360"
  license "AGPL-3.0"
  head "https://github.com/kckylechen1/tachi.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "build", "--release", "-p", "memory-server",
           "--target-dir", buildpath/"target"
    bin.install buildpath/"target/release/memory-server" => "tachi"
  end

  test do
    assert_match "tachi", shell_output("#{bin}/tachi --version")
  end

  def caveats
    <<~EOS
      To use Tachi with your AI agent, add to your MCP config:

        {
          "mcpServers": {
            "tachi": {
              "command": "#{HOMEBREW_PREFIX}/bin/tachi"
            }
          }
        }

      API keys (optional, for embedding + LLM features):
        export VOYAGE_API_KEY="your_key"
        export SILICONFLOW_API_KEY="your_key"
    EOS
  end
end
