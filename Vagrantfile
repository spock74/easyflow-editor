# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # Define a imagem da VM. Usaremos Ubuntu 22.04 LTS, que é muito estável.
  config.vm.box = "bento/ubuntu-22.04"


  # Define o provedor como VMware
  config.vm.provider "vmware" do |v|
    # Aloca recursos para a VM. Ajuste conforme necessário.
    v.memory = "4096" # 4GB de RAM
    v.cpus = "2"      # 2 CPUs
    v.gui = false     # Não precisamos da interface gráfica do Ubuntu
  end

  # Sincroniza a pasta atual do seu Mac para a pasta /vagrant dentro da VM
  config.vm.synced_folder ".", "/vagrant"

  # Ativa o encaminhamento de X11 para que a janela da aplicação apareça no seu Mac
  config.ssh.forward_x11 = true

  # Roda nosso script de provisionamento (provision.sh) na primeira vez que a VM for criada
  config.vm.provision "shell", path: "provision.sh"
end