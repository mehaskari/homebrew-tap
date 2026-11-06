class Xping < Formula
  include Language::Python::Virtualenv

  desc "Beautiful CLI network diagnostics: ping, trace, mtr, DNS, TLS, HTTP and more"
  homepage "https://mehaskari.github.io/xping/"
  url "https://files.pythonhosted.org/packages/36/cc/fe616ee5b7aba57f7171cc80382eb121b1fb210dcedccab46536ffa44661/xping-1.8.0.tar.gz"
  sha256 "bad4363ac344011175038d6553ca00157ac62e19d01f1b56da559ef9cdf68557"
  license "MIT"

  depends_on "python@3.14"

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/fd/11/b524cbd9bbdaca58608e4cf4053fd463417549e1959fa8d3aa18319f9555/certifi-2026.10.23.tar.gz"
    sha256 "a9895e6e2758b371e0545e321a3a8fd1fcfd9829ada8824a936dfb16aaaf36cd"
  end

  def install
    virtualenv_install_with_resources
    man1.install_symlink libexec/"share/man/man1/xping.1" if (libexec/"share/man/man1/xping.1").exist?
    generate_completions_from_executable(bin/"xping", "completion")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/xping --version")
    assert_match "TCP", shell_output("#{bin}/xping tcp --help")
  end
end
