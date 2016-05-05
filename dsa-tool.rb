require 'formula'

class DsaTool < Formula
  desc "DSA Development Tool"
  homepage "https://github.com/IOT-DSA/tool"

  head "https://github.com/IOT-DSA/tool.git"
  url "https://github.com/IOT-DSA/tool/releases/download/v0.0.1/tool.zip"
  sha256 "071b361b369bb209fb7a7a1658b6c7548cc6ce60145ba20f0039c085a742abcd"
  version "0.0.1"

  depends_on "dart"
  depends_on "coreutils"

  def install
    system "pub", "get"
    system "gcp", "-Lr", "packages/", "pkgs/"
    system "rm", "-r", "packages/"
    system "mv", "pkgs", "packages"
    libexec.install Dir["*"]
    (bin + "dsa").write shim_script "bin/dsa.dart"
  end

  def shim_script target
    <<-EOS.undent
      #!/bin/bash
      exec dart "#{libexec}/#{target}" "${@}"
    EOS
  end

  test do
    system "dsa"
  end
end
