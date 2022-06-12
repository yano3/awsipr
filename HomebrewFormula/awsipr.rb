# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Awsipr < Formula
  desc "Checks whether an IP address is in AWS ranges."
  homepage "https://github.com/yano3/awsipr"
  version "0.1.2"
  license "MIT"

  on_macos do
    url "https://github.com/yano3/awsipr/releases/download/v0.1.2/awsipr_darwin_amd64.zip"
    sha256 "8762604017ad3765f568c20c468205381cfb3e40b0f6a94d0325db99a9b8f574"

    def install
      bin.install "awsipr"
    end

    if Hardware::CPU.arm?
      def caveats
        <<~EOS
          The darwin_arm64 architecture is not supported for the Awsipr
          formula at this time. The darwin_amd64 binary may work in compatibility
          mode, but it might not be fully supported.
        EOS
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/yano3/awsipr/releases/download/v0.1.2/awsipr_linux_amd64.zip"
      sha256 "ceccc8ef282d5033c1f54008aceaf8af3a425cf8102c549f79988826849ea607"

      def install
        bin.install "awsipr"
      end
    end
  end
end
