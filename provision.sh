#!/bin/bash

echo ">>> Iniciando provisionamento da VM de desenvolvimento..."

# Atualiza a lista de pacotes
sudo apt-get update -y

# Instala dependências essenciais e para o Tauri/OpenCV no Ubuntu/Debian
echo ">>> Instalando dependências do sistema..."
sudo apt-get install -y build-essential curl pkg-config libssl-dev libgtk-3-dev libwebkit2gtk-4.0-dev librsvg2-dev libopencv-dev xorg openbox

# --- CORREÇÃO DA INSTALAÇÃO DO RUST ---
echo ">>> Instalando Rust de forma robusta..."
# Instala o rustup com -y (aceita defaults) e --no-modify-path (NÃO tenta editar o .profile automaticamente)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path

# Adiciona a configuração do cargo ao PATH manualmente no .bashrc para futuras sessões ssh
echo 'source "$HOME/.cargo/env"' >> /home/vagrant/.bashrc

# Adiciona o cargo ao PATH da sessão ATUAL para que os comandos seguintes (se houver) funcionem
source "/home/vagrant/.cargo/env"
# ------------------------------------

# Instala o Node.js v20.x e o pnpm
echo ">>> Instalando Node.js e pnpm..."
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo npm install -g pnpm

echo ">>> Provisionamento concluído! Ambiente pronto."