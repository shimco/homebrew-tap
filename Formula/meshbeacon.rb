class Meshbeacon < Formula
  desc "Local LAN media gateway and smart TV autodiscovery beacon"
  homepage "https://shimmin.co/logs/meshbeacon-smart-tvs-wireguard-go"
  version "0.8.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/shimco/meshbeacon/releases/download/v0.8.2/meshbeacon_darwin_arm64.tar.gz"
      sha256 "9aba26da71dfa21e318dbbb72466ef35f86b876bebbd3654c0997a3364d619c6"
    else
      url "https://github.com/shimco/meshbeacon/releases/download/v0.8.2/meshbeacon_darwin_amd64.tar.gz"
      sha256 "982890d9122b612ea4efa7f88ea8efeda49c178a5d362612d78f91db7c6d6e5e"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/shimco/meshbeacon/releases/download/v0.8.2/meshbeacon_linux_arm64.tar.gz"
      sha256 "bcc21296099b7056a96dfa001cb46f6ccca7b37bacea6c1697ca545bd0a8a3b8"
    elsif Hardware::CPU.intel?
      url "https://github.com/shimco/meshbeacon/releases/download/v0.8.2/meshbeacon_linux_amd64.tar.gz"
      sha256 "7955cd0c7ec0a893d2658139621032529f63c8dc5bce801f1a64bcebd6a326f7"
    end
  end

  def install
    bin.install "meshbeacon"
    (etc/"meshbeacon").install "meshbeacon.example.json" => "meshbeacon.json" unless (etc/"meshbeacon/meshbeacon.json").exist?
  end

  service do
    run [opt_bin/"meshbeacon", "-config", etc/"meshbeacon/meshbeacon.json"]
    keep_alive true
    log_path var/"log/meshbeacon.log"
    error_log_path var/"log/meshbeacon.log"
  end

  test do
    system "#{bin}/meshbeacon", "-version"
  end
end
