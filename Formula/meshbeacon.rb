class Meshbeacon < Formula
  desc "Local LAN media gateway and smart TV autodiscovery beacon"
  homepage "https://shimmin.co/logs/meshbeacon-smart-tvs-wireguard-go"
  version "0.8.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/shimco/meshbeacon/releases/download/v0.8.0/meshbeacon_darwin_arm64.tar.gz"
      sha256 "a25a323c3c2f9ea95343590113a4e806e2bc0b326a38d1888aac89456f2f2620"
    else
      url "https://github.com/shimco/meshbeacon/releases/download/v0.8.0/meshbeacon_darwin_amd64.tar.gz"
      sha256 "5ec39205d64ec3d926526607c1f62c14ca83fd39f62ab6ff7169b9a6bd2e10c4"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/shimco/meshbeacon/releases/download/v0.8.0/meshbeacon_linux_arm64.tar.gz"
      sha256 "1f9769dc90385fd5bbcab1efd8b778ba3214b8a22b912b0d47832f87511b31ee"
    elsif Hardware::CPU.intel?
      url "https://github.com/shimco/meshbeacon/releases/download/v0.8.0/meshbeacon_linux_amd64.tar.gz"
      sha256 "6def3082d191dd841d256284b5dddce93d1a31613faec09dd6e4ffdf4d9c7af0"
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
