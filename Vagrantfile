Vagrant.configure("2") do |config|
  config.vm.box = "debian/bookworm64"

  config.vm.define "servidor" do |srv|
    srv.vm.network "private_network", ip: "192.168.56.10"
    srv.vm.provision "shell", path: "config/provision-servidor.sh"
    srv.vm.provision "shell", path: "config/test-final.sh"
  end

  config.vm.define "secundario" do |sec|
    sec.vm.network "private_network", ip: "192.168.56.11"
  end
end
