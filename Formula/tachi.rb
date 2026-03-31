class Tachi < Formula
  desc "Local-first memory + Hub for AI agents (MCP server)"
  homepage "https://github.com/kckylechen1/tachi"
  url "https://github.com/kckylechen1/tachi/archive/refs/tags/v0.12.2.tar.gz"
  sha256 "ebf976362bccbfa5c5e552128b94cb4dabc7a05e6c748834bdab7bb981424663"
  license "AGPL-3.0"
  head "https://github.com/kckylechen1/tachi.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "rust" => :build

  def install
    system "cargo", "build", "--release", "--locked", "-p", "memory-server",
           "--target-dir", buildpath/"target"
    bin.install buildpath/"target/release/memory-server" => "tachi"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tachi --version")
    assert_match "memory + Hub MCP server", shell_output("#{bin}/tachi --help")

    db_path = testpath/"tachi-homebrew-test.db"
    text = "Homebrew smoke test memory"

    saved = shell_output("MEMORY_DB_PATH=#{db_path} #{bin}/tachi --no-project-db save --path /test/homebrew '#{text}'")
    assert_match '"saved": true', saved

    stats = shell_output("MEMORY_DB_PATH=#{db_path} #{bin}/tachi --no-project-db stats")
    assert_match '"total": 1', stats
    assert_match db_path.to_s, stats
  end

  def caveats
    <<~EOS
      Tachi is installed at:

        #{opt_bin}/tachi

      To use Tachi with your MCP client, add this command to your config:

        {
          "mcpServers": {
            "tachi": {
              "command": "#{opt_bin}/tachi"
            }
          }
        }

      Optional environment variables:
        export VOYAGE_API_KEY="your_key"
        export SILICONFLOW_API_KEY="your_key"
        export MEMORY_DB_PATH="$HOME/.Tachi/global/memory.db"

      Quick smoke test:
        tachi --help
        tachi --no-project-db stats
    EOS
  end
end
