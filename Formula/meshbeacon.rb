class Meshbeacon < Formula
  desc "Local LAN media gateway and smart TV autodiscovery beacon"
  homepage "https://shimmin.co/logs/meshbeacon-smart-tvs-wireguard-go"
  version "0.8.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/shimco/meshbeacon/releases/download/v0.8.3/meshbeacon_darwin_arm64.tar.gz"
      sha256 "837160ba72de22ca7506af6dd292877e9d073eafcc4ecd1bec5d688ffa85eba5"
    else
      url "https://github.com/shimco/meshbeacon/releases/download/v0.8.3/meshbeacon_darwin_amd64.tar.gz"
      sha256 "19065d96b6d0b091ce9e193171ea0d1888341cabcfd0fcda9a9b4f4fd8b6d8cc"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/shimco/meshbeacon/releases/download/v0.8.3/meshbeacon_linux_arm64.tar.gz"
      sha256 "00593af857321a4390253f2d59f57457d4012e521c36f5f03d878a1f0c8332e8"
    elsif Hardware::CPU.intel?
      url "https://github.com/shimco/meshbeacon/releases/download/v0.8.3/meshbeacon_linux_amd64.tar.gz"
      sha256 "1f5f5acda40e44bb48dc88c83ff82ebb85500b98f08de64e84b79e841974a6d1"
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
