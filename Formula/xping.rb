class Xping < Formula
  include Language::Python::Virtualenv

  desc "Beautiful CLI network diagnostics: ping, trace, mtr, DNS, TLS, HTTP and more"
  homepage "https://mehaskari.github.io/xping/"
  url "https://files.pythonhosted.org/packages/f9/a8/c85f8624033ac98a14739136353c1b6c8c62cce9f0dddf9405236f3e1dd3/xping-1.6.0.tar.gz"
  sha256 "625d89b8e97a3d69ccd351b898f4a983c8b58edc04f84bd05f7fc77dc542229d"
  license "MIT"

  depends_on "python@3.14"

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/a6/bd/1436c50cc46699de0230fbaacc1d1de7bfec413176099949e9d5112e88f2/certifi-2026.10.19.tar.gz"
    sha256 "035c1e85572b141bf1c3a3eff0e33a8eb74917522f2559075ff8d2fea780a1ae"
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
