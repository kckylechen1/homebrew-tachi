class Tachi < Formula
  desc "Local-first memory + Hub for AI agents (MCP server)"
  homepage "https://github.com/kckylechen1/tachi"
  url "https://github.com/kckylechen1/tachi/archive/refs/tags/v0.16.4.tar.gz"
  sha256 "d4394e1231c463901e7aac32549fe5112a46d7dd02ef855427b022ab7d737b55"
  license "AGPL-3.0"
  head "https://github.com/kckylechen1/tachi.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "rust" => :build

  def install
    system "cargo", "build", "--release", "--locked", "-p", "memory-server",
           "--bins",
           "--target-dir", buildpath/"target"
    bin.install buildpath/"target/release/memory-server" => "tachi"
    bin.install buildpath/"target/release/tachi-hub" => "tachi-hub"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tachi --version")
    assert_match "memory + Hub MCP server", shell_output("#{bin}/tachi --help")
    assert_match version.to_s, shell_output("#{bin}/tachi-hub --version")
    assert_match "Inspect Tachi Hub registry", shell_output("#{bin}/tachi-hub --help")

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
        #{opt_bin}/tachi-hub

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
        tachi-hub stats
    EOS
  end
end
