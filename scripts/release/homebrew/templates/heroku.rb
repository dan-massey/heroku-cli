# This file is automatically generated by https://github.com/heroku/cli/blob/main/scripts/release/homebrew.js
# Do not update this file directly;
# Please update the template instead:
# https://github.com/heroku/cli/blob/main/scripts/release/homebrew/templates/heroku.rb
class Heroku < Formula
  desc "Everything you need to get started with Heroku"
  homepage "https://cli.heroku.com"
  url "__CLI_DOWNLOAD_URL__"
  sha256 "__CLI_SHA256__"
  version "__CLI_VERSION__"
  version_scheme 1

  on_macos do
    if Hardware::CPU.arm?
      url "__CLI_DOWNLOAD_URL_M1__"
      sha256 "__CLI_SHA256_M1__"
    end
  end

  def install
    inreplace "bin/heroku", /^CLIENT_HOME=/, "export HEROKU_OCLIF_CLIENT_HOME=#{lib/"client"}\nCLIENT_HOME="
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/heroku"

    bash_completion.install libexec/"autocomplete-scripts/brew/bash" => "heroku"
    zsh_completion.install libexec/"autocomplete-scripts/brew/zsh/_heroku"
  end

  def caveats; <<~EOS
    To use the Heroku CLI's autocomplete --
      Via homebrew's shell completion:
        1) Follow homebrew's install instructions https://docs.brew.sh/Shell-Completion
            NOTE: For zsh, as the instructions mention, be sure compinit is autoloaded
                  and called, either explicitly or via a framework like oh-my-zsh.
        2) Then run
          $ heroku autocomplete --refresh-cache
      OR
      Use our standalone setup:
        1) Run and follow the install steps:
          $ heroku autocomplete
  EOS
  end

  test do
    system bin/"heroku", "version"
  end
end
