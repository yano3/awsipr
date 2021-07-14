# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Awsipr < Formula
  desc "Checks whether an IP address is in AWS ranges."
  homepage "https://github.com/yano3/awsipr"
  version "0.1.1"
  license "MIT"
  bottle :unneeded

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/yano3/awsipr/releases/download/v0.1.1/awsipr_darwin_amd64.zip"
      sha256 "5d843e948871146e9d6181caa33de0dbca62063e248c8eece44da2730e231d9b"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/yano3/awsipr/releases/download/v0.1.1/awsipr_linux_amd64.zip"
      sha256 "bfd49dae64ccd36a2c41e486653d293b0064c32d21445c819b220321b4c34039"
    end
  end

  def install
    bin.install "awsipr"
  end
end
