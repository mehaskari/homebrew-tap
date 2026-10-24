class Xping < Formula
  include Language::Python::Virtualenv

  desc "Beautiful CLI network diagnostics: ping, trace, mtr, DNS, TLS, HTTP and more"
  homepage "https://mehaskari.github.io/xping/"
  url "https://files.pythonhosted.org/packages/c7/cd/d749553533d59b29c9a7133c5d0cd172a50d926a803ca3afd67c1b97cbdf/xping-1.6.1.tar.gz"
  sha256 "483318fcae1743d57eae68dbe9301dee7b0b62b5c27ca8dcff90299ca1612f26"
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
