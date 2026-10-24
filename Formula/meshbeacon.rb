class Meshbeacon < Formula
  desc "Local LAN media gateway and smart TV autodiscovery beacon"
  homepage "https://shimmin.co/logs/meshbeacon-smart-tvs-wireguard-go"
  version "0.8.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/shimco/meshbeacon/releases/download/v0.8.1/meshbeacon_darwin_arm64.tar.gz"
      sha256 "0ed8a941f2213d6e93473fac3875509404d3f66065490f7b4bc04d596adb8b13"
    else
      url "https://github.com/shimco/meshbeacon/releases/download/v0.8.1/meshbeacon_darwin_amd64.tar.gz"
      sha256 "5fa5552e8db6bbc8765a606a8e26cf18655bc93085fe98d35760507cf25aaff4"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/shimco/meshbeacon/releases/download/v0.8.1/meshbeacon_linux_arm64.tar.gz"
      sha256 "f867113ff7491a1df284dc8689d66ec6095fdae333a1835ba14bee76a84b1a28"
    elsif Hardware::CPU.intel?
      url "https://github.com/shimco/meshbeacon/releases/download/v0.8.1/meshbeacon_linux_amd64.tar.gz"
      sha256 "05992f9ec1a33cbb1281186f408d631a6f66af2830ae346f308c58522c025dac"
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
