# EasyFlow Editor - By spock74

[Read it in English](https://www.google.com/search?q=README.en.md)

-----

> Atenção: este projeto encontra-se em fase **absolutamente incipiente**, incluindo refinamento de sua concepção, roadmap e confirmação da adequação do status de tecnologias. **Nascimento: 01 Set 2025**

[](https://www.google.com/search?q=https://github.com/SEU_USUARIO/easyflow-editor)
[](https://www.google.com/search?q=/LICENSE)

### Além do comando "/"

> Em duas palavras: UI multimodal

`EasyFlow Editor` (*running name*) é um projeto de aplicação de desktop que reimagina a interação com editores de texto.

Inspirado na flexibilidade do Notion e focado em uma interface limpa e usabilidade maximamente fluida.

Um dos focos é a extensão da UI para incluir interação multimodal na interação do usuário, aumentando exponencialmente a agilidade e a produtividade.

  - gestos de mão e cabeça - usando processamento de vídeo com opencv (do stream da webcam),

  - comandos de voz - processamento do stream do microfone
    O objetivo é reduzir a dependência do mouse e de menus visuais, permitindo que o usuário mantenha um estado de "fluxo" contínuo.

-----

## Stack

### Tauri + SvelteKit + TypeScript template by Spock74

This template is designed to help start developing with Tauri, SvelteKit and TypeScript in Vite.

### Recommended IDE Setup

[VS Code](https://code.visualstudio.com/) + [Svelte](https://marketplace.visualstudio.com/items?itemName=svelte.svelte-vscode) + [Tauri](https://marketplace.visualstudio.com/items?itemName=tauri-apps.tauri-vscode) + [rust-analyzer](https://marketplace.visualstudio.com/items?itemName=rust-lang.rust-analyzer).

-----

## Índice

  * [Sobre o Projeto](https://www.google.com/search?q=%23-sobre-o-projeto)
  * [Funcionalidades Principais](https://www.google.com/search?q=%23-funcionalidades-principais)
  * [Stack Tecnológico](https://www.google.com/search?q=%23%EF%B8%8F-stack-tecnol%C3%B3gico)
  * [Arquitetura](https://www.google.com/search?q=%23%EF%B8%8F-arquitetura)
  * [Começando (Desenvolvimento Local)](https://www.google.com/search?q=%23-come%C3%A7ando-desenvolvimento-local)
      * [Pré-requisitos](https://www.google.com/search?q=%23pr%C3%A9-requisitos)
      * [Instalação](https://www.google.com/search?q=%23instala%C3%A7%C3%A3o)
      * [Configuração do Firebase](https://www.google.com/search?q=%23configura%C3%A7%C3%A3o-do-firebase)
  * [Ambiente de Desenvolvimento Recomendado](https://www.google.com/search?q=%23-ambiente-de-desenvolvimento-recomendado)
  * [Roadmap](https://www.google.com/search?q=%23%EF%B8%8F-roadmap)
  * [Contribuindo](https://www.google.com/search?q=%23-contribuindo)
  * [Licença](https://www.google.com/search?q=%23-licen%C3%A7a)

-----

## Sobre o Projeto

A produtividade moderna é frequentemente interrompida pela necessidade de alternar entre teclado e mouse, navegar por menus complexos e gerenciar uma interface poluída. O EasyFlow Editor aborda esse problema ao oferecer uma UI que se afasta do caminho, priorizando o conteúdo.

A principal inovação é um motor de interação inteligente que, com a permissão do usuário, utiliza a webcam para interpretar gestos, transformando movimentos intuitivos em ações de edição, como selecionar, mover e formatar blocos de texto.

Este projeto é construído sobre uma base de tecnologias modernas, priorizando performance e uma experiência de usuário robusta através de uma arquitetura nativa.

## Funcionalidades Principais

  * **Editor Baseado em Blocos:** Criação e reestruturação de conteúdo de forma flexível, similar ao Notion.
  * **Interface Minimalista:** Uma tela sem distrações, onde a UI é exibida somente quando necessário.
  * **Interação Multimodal (Em Desenvolvimento):**
      * **Controle por Gestos de Mão:** Uso de gestos como "pinça" para pegar e mover blocos, "swipe" para navegar e "mão aberta/fechada" para selecionar.
      * **Controle por Gestos de Cabeça:** Uso de movimentos como "acenar" e "negar" para confirmar ou cancelar ações.
  * **Sincronização na Nuvem (Planejado):** Os documentos são salvos e sincronizados em tempo real entre dispositivos através do Firebase.
  * **Modo Offline:** Permite o trabalho sem conexão com a internet; as alterações são sincronizadas ao reconectar.

## Stack Tecnológico

Este projeto utiliza um conjunto de tecnologias modernas para garantir performance, segurança e uma ótima experiência de desenvolvimento.

  * **Framework da Aplicação:** [Tauri](https://tauri.app/) - Permite criar aplicações de desktop leves e seguras com um backend em Rust e um frontend baseado em tecnologias web.
  * **Linguagem do Backend:** [Rust](https://www.rust-lang.org/) - Para performance, segurança de memória e controle de baixo nível no processamento principal.
  * **Frontend:** Flexível (React, Vue, Svelte, etc.) - O scaffolding inicial permite a escolha de uma framework preferida com TypeScript.
  * **Visão Computacional (CV):**
      * [OpenCV](https://opencv.org/) - Para operações clássicas de CV, como pré-processamento de imagem e análise de movimento.
      * [ONNX Runtime](https://onnxruntime.ai/) - Para executar modelos de IA de forma eficiente e multiplataforma, realizando a detecção robusta de âncoras (mãos, rosto) e análise de poses complexas.
  * **Serviços de Nuvem (Backend):** [Firebase](https://firebase.google.com/)
      * **Autenticação:** Firebase Authentication
      * **Banco de Dados:** Cloud Firestore (para sincronização em tempo real e modo offline)
      * **Armazenamento de Arquivos:** Cloud Storage

### Exemplo de instalação do OpenCV como dependência

A estrutura básica criada é:

```text
src-tauri/
└── src/
    ├── cv/
    │   ├── mod.rs
    │   └── processing.rs  <-- Lugar ideal para o código OpenCV
    ├── core/
    │   └── ...
    └── main.rs
```

Intencionalmente **não foi adicionada a biblioteca (crate) do OpenCV**. Este é o padrão para manter o projeto inicial leve e para controle total sobre qual versão e quais módulos do OpenCV (e outros) serão adicionados.

### Instalando OpenCV: 2 Passos

Para usar o OpenCV no backend Rust, são necessárias duas coisas: as bibliotecas do OpenCV no sistema local e o "crate" do Rust que se comunica com elas.

#### Passo 1: Instalar as Bibliotecas do OpenCV no Sistema

O crate `opencv` para Rust é um *binding*, o que significa que ele "conversa" com a biblioteca C++ do OpenCV que precisa estar instalada.

No macOS, a maneira mais fácil de instalar é usando o [Homebrew](https://brew.sh/):

```zsh
# Executar no terminal:
brew install opencv
```

Isso irá baixar e instalar a versão mais recente das bibliotecas do OpenCV, deixando-as prontas para serem usadas pelo Rust.

#### Passo 2: Adicionar o Crate `opencv` ao Projeto Rust

Agora, é preciso informar ao `Cargo` (o gerenciador de pacotes do Rust) que o projeto depende do crate `opencv`.

1.  **Navegar até a pasta do backend:**

    ```zsh
    # A partir da raiz do projeto (ex: 'easyflow-editor')
    cd src-tauri
    ```

2.  **Adicionar o crate usando o Cargo:**
    A maneira mais moderna e recomendada é usar o comando `cargo add`. Ele automaticamente encontrará a versão mais recente e a adicionará ao `Cargo.toml`.

    ```zsh
    cargo add opencv
    ```

Após executar este comando, ao abrir o arquivo `src-tauri/Cargo.toml`, será exibida uma nova linha na seção `[dependencies]`, algo como:

```toml
[dependencies]
opencv = "0.88.8" # A versão pode ser mais recente
serde = { version = "1.0", features = ["derive"] }
serde_json = "1.0"
tauri = { version = "1.6", features = ["shell-open"] }
```

### Exemplo Prático: Usando o OpenCV

Com a dependência adicionada, é possível começar a usar o OpenCV. Modifica-se o arquivo placeholder `src-tauri/src/cv/processing.rs` para um "Olá, Mundo\!" do OpenCV.

Substitui-se o conteúdo de `src-tauri/src/cv/processing.rs` por este código:

```rust
// src-tauri/src/cv/processing.rs

// Importar os tipos e funções necessários do OpenCV
use opencv::{
    core,
    highgui,
    prelude::*,
};

// Uma função para testar se o OpenCV está funcionando
pub fn show_test_window() -> opencv::Result<()> {
    let window = "Janela de Teste OpenCV";
    highgui::named_window(window, highgui::WINDOW_AUTOSIZE)?;

    // Cria uma imagem preta de 800x600
    let mat = Mat::new_rows_cols_with_default(
        600,
        800,
        core::CV_8UC3,
        core::Scalar::new(0.0, 0.0, 0.0, 0.0)
    )?;

    // Mostra a imagem na janela
    highgui::imshow(window, &mat)?;

    // Espera por 5000 ms (5 segundos) ou até uma tecla ser pressionada
    highgui::wait_key(5000)?;

    println!("Janela de teste do OpenCV foi exibida com sucesso.");

    Ok(())
}
```

E para chamar essa função, pode-se criar um comando de teste em `src-tauri/src/core/commands.rs`:

```rust
// src-tauri/src/core/commands.rs

use crate::cv; // Importa o módulo de CV

#[tauri::command]
pub fn greet(name: &str) -> String {
    format!("Olá, {}! Você foi chamado a partir do Rust!", name)
}

// Novo comando para testar o OpenCV
#[tauri::command]
pub fn show_opencv_window() {
    // Chama a função do módulo de processamento
    if let Err(e) = cv::processing::show_test_window() {
        eprintln!("Erro ao exibir a janela do OpenCV: {:?}", e);
    }
}
```

O novo comando deve ser registrado no `main.rs`.

**Em resumo:** O script criou o local, mas a **instalação e adição da dependência do OpenCV é um passo manual** que dá controle total sobre a integração. Agora é possível começar a construir as funcionalidades de visão computacional.

## Arquitetura

O EasyFlow Editor é uma aplicação de desktop nativa, e não um site empacotado.

1.  **Core (Rust):** O processo principal é escrito em Rust. Ele gerencia a janela, o estado da aplicação e toda a lógica de negócios pesada, incluindo o pipeline de visão computacional.
2.  **Interface (WebView):** A UI é renderizada em um WebView nativo do sistema operacional, permitindo o uso de tecnologias web modernas para criar uma interface rica e responsiva.
3.  **Comunicação:** A comunicação entre o frontend (JavaScript/TypeScript) e o backend (Rust) é feita de forma segura e eficiente através de um bridge de interoperabilidade fornecido pelo Tauri.
4.  **Pipeline de CV Híbrido:** Para equilibrar performance e precisão, adota-se uma abordagem híbrida:
      * Um modelo de IA leve (via ONNX) detecta as "âncoras" (mãos, rosto) de forma robusta.
      * Algoritmos do OpenCV rastreiam e analisam o movimento simples dentro dessas regiões de interesse (ROI).
      * Um modelo de IA de estimação de pose mais detalhado é invocado apenas quando necessário para reconhecer gestos complexos.

## Começando (Desenvolvimento Local)

Os passos a seguir descrevem como configurar e executar o projeto em uma máquina local.

### Pré-requisitos

É necessário ter o seguinte instalado:

1.  **Rust e Cargo:** `curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh`
2.  **Node.js e Gerenciador de Pacotes:** Recomenda-se o `pnpm`.
3.  **Pré-requisitos do Tauri:** Seguir o [guia oficial do Tauri](https://tauri.app/v1/guides/getting-started/prerequisites) para instalar as dependências de desenvolvimento do sistema operacional (essencial para compilação).

### Instalação

1.  **Clone o repositório:**

    ```sh
    git clone https://github.com/SEU_USUARIO/easyflow-editor.git
    cd easyflow-editor
    ```

2.  **Instale as dependências do frontend:**

    ```sh
    pnpm install
    ```

3.  **Configure o Firebase (passo crucial):**

      * Seguir as instruções na seção [Configuração do Firebase](https://www.google.com/search?q=%23configura%C3%A7%C3%A3o-do-firebase) abaixo.

4.  **Execute o ambiente de desenvolvimento:**

    ```sh
    pnpm tauri dev
    ```

    Isso abrirá a janela do aplicativo e reconstruirá automaticamente o backend e o frontend sempre que houver alterações nos arquivos.

### Configuração do Firebase

Para que as funcionalidades de nuvem (login, sincronização) funcionem, é preciso conectar o projeto a uma instância própria do Firebase.

1.  Acessar o [Console do Firebase](https://console.firebase.google.com/) e criar um novo projeto.
2.  Dentro do projeto, os seguintes serviços devem ser ativados:
      * **Authentication:** Na aba "Authentication", ativar os provedores de login desejados (ex: "E-mail/senha", "Google").
      * **Firestore Database:** Criar um novo banco de dados Firestore. Iniciar no modo de teste para facilitar o desenvolvimento.
      * **Storage:** Ativar o Cloud Storage.
3.  Nas "Configurações do Projeto" e, na aba "Geral", encontrar as credenciais de configuração da web (`firebaseConfig`).
4.  Criar um arquivo `.env` na raiz do projeto e adicionar as credenciais. O backend em Rust é configurado para ler este arquivo e expor as credenciais de forma segura ao frontend.
    ```env
    # .env
    VITE_FIREBASE_API_KEY="SUA_API_KEY"
    VITE_FIREBEASE_AUTH_DOMAIN="SEU_AUTH_DOMAIN"
    # ...e assim por diante para todas as chaves do objeto firebaseConfig.
    ```

## Ambiente de Desenvolvimento Recomendado

Recomenda-se o uso do **Visual Studio Code** com as extensões sugeridas no arquivo `.vscode/extensions.json`. Ao abrir o projeto, o VS Code notificará para que sejam instaladas as extensões recomendadas, que incluem:

  * `rust-analyzer`: Suporte completo à linguagem Rust.
  * `Tauri`: Comandos e integração com o Tauri.
  * `CodeLLDB`: Para depuração do código Rust.
  * E outras ferramentas para qualidade de código do frontend.

## Roadmap

  - [x] Scaffolding do projeto com Tauri, Rust e Frontend.
  - [ ] Módulo base de Visão Computacional (captura de câmera e exibição).
  - [ ] Implementação de gestos de cabeça (aceno, negação).
  - [ ] Implementação de gestos de mão (MVP: pinça, swipe, abrir/fechar).
  - [ ] Integração com Firebase Authentication para login de usuários.
  - [ ] Estrutura do editor de blocos no frontend.
  - [ ] Sincronização de documentos com o Firestore.
  - [ ] Armazenamento de imagens no Cloud Storage.

## Contribuindo

Contribuições são o que tornam a comunidade de código aberto um lugar incrível para aprender, inspirar e criar. Qualquer contribuição feita será **muito bem-vinda**.

1.  Fazer um Fork do Projeto
2.  Criar uma Feature Branch (`git checkout -b feature/AmazingFeature`)
3.  Fazer o Commit das alterações (`git commit -m 'Add some AmazingFeature'`)
4.  Fazer o Push para a Branch (`git push origin feature/AmazingFeature`)
5.  Abrir um Pull Request

## Licença

Distribuído sob a Licença MIT. Consultar `LICENSE` para mais informações.
