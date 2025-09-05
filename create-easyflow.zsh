#!/bin/zsh

# ==============================================================================
# Scaffolding Script para o EasyFlow Editor (v3 - Corrigido para criação de projeto)
#
# Este script automatiza a criação de um novo projeto Tauri com uma
# estrutura de backend Rust modular e configurações recomendadas para VS Code.
# ==============================================================================

# --- Configurações e Cores ---
C_BLUE="\033[34m"
C_GREEN="\033[32m"
C_YELLOW="\033[33m"
C_RED="\033[31m"
C_BOLD="\033[1m"
C_RESET="\033[0m"

# Escolha seu gerenciador de pacotes preferido: pnpm, npm, ou yarn
PKG_MANAGER="pnpm"

# --- Funções Auxiliares ---
print_info() {
  echo -e "${C_BLUE}ℹ  $1${C_RESET}"
}

print_success() {
  echo -e "${C_GREEN}✔  $1${C_RESET}"
}

print_warning() {
  echo -e "${C_YELLOW}⚠  $1${C_RESET}"
}

print_error() {
  echo -e "${C_RED}✖  $1${C_RESET}"
}

# --- Verificação de Dependências ---
check_deps() {
  print_info "Verificando dependências..."
  local has_error=0
  
  if ! command -v $PKG_MANAGER &> /dev/null; then
    print_error "O gerenciador de pacotes '$PKG_MANAGER' não foi encontrado. Por favor, instale-o ou mude a variável PKG_MANAGER no script."
    has_error=1
  fi

  if ! command -v rustc &> /dev/null || ! command -v cargo &> /dev/null; then
    print_error "O toolchain do Rust (rustc, cargo) não foi encontrado. Por favor, instale-o a partir de https://rustup.rs/"
    has_error=1
  fi
  
  if [ $has_error -eq 1 ]; then
    exit 1
  fi
  
  print_success "Todas as dependências foram encontradas."
}

# --- Script Principal ---
main() {
  clear
  echo -e "${C_BOLD}${C_BLUE}🚀 Bem-vindo ao Scaffolder do EasyFlow Editor 🚀${C_RESET}\n"

  check_deps

  # --- Obter Nome do Projeto ---
  echo -n -e "${C_YELLOW}Qual será o nome do projeto? (pressione Enter para 'easyflow-editor'): ${C_RESET}"
  read projectName
  projectName=${projectName:-"easyflow-editor"}

  if [ -d "$projectName" ]; then
    print_error "O diretório '$projectName' já existe. Por favor, escolha outro nome ou remova o diretório existente."
    exit 1
  fi

  # --- Executar Scaffolder Oficial do Tauri ---
  print_info "\nO script agora irá executar a ferramenta oficial 'create-tauri-app'."
  print_info "O nome do projeto será '$projectName'."
  print_info "Siga as instruções interativas para configurar o restante (UI, flavor, etc.)."
  print_warning "Recomendamos 'React' ou 'Vue' ou 'Svelte' com 'TypeScript' para o frontend."
  
  # =======================================================================
  # ALTERAÇÃO CHAVE AQUI: Passamos $projectName como argumento.
  # Isso cria o diretório com o nome correto e pula a primeira pergunta da ferramenta.
  # =======================================================================
  $PKG_MANAGER create tauri-app@latest "$projectName"
  
  if [ ! -d "$projectName" ]; then
      print_error "A criação do projeto Tauri falhou ou foi cancelada."
      print_error "O diretório '$projectName' não foi encontrado."
      exit 1
  fi

  cd "$projectName"

  # --- Customizar a Estrutura do Backend Rust ---
  print_info "\nCustomizando a estrutura do backend Rust para maior escalabilidade..."
  
  # Remover o main.rs padrão para substituí-lo
  rm -f src-tauri/src/main.rs

  # Criar a nova estrutura de módulos
  mkdir -p src-tauri/src/core
  mkdir -p src-tauri/src/cv

  # --- Criar novos arquivos Rust com conteúdo inicial ---

  # src-tauri/src/main.rs (Ponto de Entrada)
  cat << EOF > src-tauri/src/main.rs
#![cfg_attr(
    all(not(debug_assertions), target_os = "windows"),
    windows_subsystem = "windows"
)]

mod core;
mod cv;

fn main() {
    // Aqui registraremos comandos e estado no futuro
    let invoke_handler = tauri::generate_handler![
        core::commands::greet
    ];

    tauri::Builder::default()
        .invoke_handler(invoke_handler)
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}
EOF

  # src-tauri/src/core/mod.rs
  cat << EOF > src-tauri/src/core/mod.rs
// Este módulo conterá a lógica principal da aplicação,
// como comandos, gerenciamento de estado, etc.
pub mod commands;
EOF

  # src-tauri/src/core/commands.rs (Comandos para o Frontend)
  cat << EOF > src-tauri/src/core/commands.rs
#[tauri::command]
pub fn greet(name: &str) -> String {
    format!("Olá, {}! Você foi chamado a partir do Rust!", name)
}
EOF

  # src-tauri/src/cv/mod.rs
  cat << EOF > src-tauri/src/cv/mod.rs
// Este módulo conterá toda a lógica de Visão Computacional
// (OpenCV, ONNX, etc.)
pub mod processing;
EOF

  # src-tauri/src/cv/processing.rs (Lógica de Processamento de Vídeo)
  cat << EOF > src-tauri/src/cv/processing.rs
// Exemplo de uma função placeholder para o processamento de frames
pub fn process_frame() {
    // TODO: Implementar a lógica de processamento de imagem/vídeo aqui
    println!("Processando um frame de vídeo...");
}
EOF
  
  print_success "Estrutura do backend Rust customizada."

  # --- Configurar o Ambiente do VS Code ---
  print_info "Configurando ambiente recomendado para o VS Code..."
  mkdir -p .vscode

  # .vscode/extensions.json (Extensões Recomendadas)
  cat << 'EOF' > .vscode/extensions.json
{
  "recommendations": [
    "rust-lang.rust-analyzer",
    "tauri-apps.tauri-vscode",
    "vadimcn.vscode-lldb",
    "serayuzgur.crates",
    "dbaeumer.vscode-eslint",
    "esbenp.prettier-vscode"
  ]
}
EOF

  # .vscode/settings.json (Configurações do Workspace)
  cat << 'EOF' > .vscode/settings.json
{
  "rust-analyzer.check.command": "clippy",
  "[rust]": {
    "editor.formatOnSave": true
  },
  "[javascript]": {
    "editor.formatOnSave": true
  },
  "[typescript]": {
    "editor.formatOnSave": true
  },
  "[json]": {
    "editor.formatOnSave": true
  }
}
EOF

  print_success "Ambiente do VS Code configurado."

  # --- Mensagem Final ---
  echo -e "\n\n${C_BOLD}${C_GREEN}🎉 Projeto EasyFlow Editor ('$projectName') criado com sucesso! 🎉${C_RESET}"
  echo -e "\n${C_BOLD}Próximos Passos:${C_RESET}"
  echo -e "1. ${C_YELLOW}cd $projectName${C_RESET}"
  echo -e "2. ${C_YELLOW}$PKG_MANAGER install${C_RESET} (para instalar as dependências do frontend)"
  echo -e "3. ${C_YELLOW}$PKG_MANAGER tauri dev${C_RESET} (para iniciar o ambiente de desenvolvimento)"
  echo -e "4. Abra o projeto no VS Code e instale as extensões recomendadas (o editor irá sugerir)."
  echo -e "\n${C_BOLD}Happy coding!${C_RESET}"
}

main
