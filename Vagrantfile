Vagrant.configure("2") do |config|
  config.vm.box = "debian/bookworm64"

  config.vm.define "servidor" do |srv|
    srv.vm.network "private_network", ip: "192.168.56.10"
  end
end