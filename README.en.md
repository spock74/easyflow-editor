# EasyFlow Editor - By spock74


[Leia este documento em Português](README.md)

---


> Disclaimer: This project is in an **extremely early stage**, including the refinement of its concept, roadmap, and validation of the chosen technology stack. **Inception Date: Sep 01, 2025**


[](https://www.google.com/search?q=https://github.com/YOUR_USERNAME/easyflow-editor)
[](https://www.google.com/search?q=/LICENSE)


### Beyond the "/" command

> In two words: Multimodal UI


`EasyFlow Editor` (_running name_) is a desktop application project that reimagines the interaction with text editors.

Inspired by Notion's flexibility and focused on a clean interface and maximum usability fluidity.

One of the core goals is to extend the UI to include multimodal interaction, exponentially increasing user agility and productivity.

- Hand and head gestures - using video processing with OpenCV (from the webcam stream),

- Voice commands - processing the microphone stream
The objective is to reduce the dependency on the mouse and visual menus, allowing the user to maintain a continuous "flow" state.

----

## Stack

### Tauri + SvelteKit + TypeScript template by Spock74

This template should help get you started developing with Tauri, SvelteKit and TypeScript in Vite.


### Recommended IDE Setup

[VS Code](https://code.visualstudio.com/) + [Svelte](https://marketplace.visualstudio.com/items?itemName=svelte.svelte-vscode) + [Tauri](https://marketplace.visualstudio.com/items?itemName=tauri-apps.tauri-vscode) + [rust-analyzer](https://marketplace.visualstudio.com/items?itemName=rust-lang.rust-analyzer).


-----



## 📜 Table of Contents

* [About The Project](#-about-the-project)
* [✨ Core Features](#-core-features)
* [🛠️ Tech Stack](#️-tech-stack)
* [🏛️ Architecture](#️-architecture)
* [🚀 Getting Started (Local Development)](#-getting-started-local-development)
  * [Prerequisites](#prerequisites)
  * [Installation](#installation)
  * [Firebase Setup](#firebase-setup)
* [💻 Recommended Development Environment](#-recommended-development-environment)
* [🗺️ Roadmap](#️-roadmap)
* [🤝 Contributing](#-contributing)
* [📄 License](#-license)

-----

## 📖 About The Project

Modern productivity is often interrupted by the need to switch between keyboard and mouse, navigate complex menus, and manage a cluttered interface. EasyFlow Editor addresses this problem by offering a UI that gets out of the way, prioritizing content.

The main innovation is an intelligent interaction engine that, with user permission, utilizes the webcam to interpret gestures, transforming intuitive movements into editing actions, such as selecting, moving, and formatting blocks of text.

This project is built on a foundation of modern technologies, prioritizing performance and a robust user experience through a native architecture.

## ✨ Core Features

  * **Block-Based Editor:** Create and restructure your content flexibly, similar to Notion.
  * **Minimalist Interface:** A distraction-free canvas where the UI only appears when you need it.
  * **Multimodal Interaction (In Development):**
      * **Hand Gesture Control:** Use gestures like "pinch" to grab and move blocks, "swipe" to navigate, and "open/closed hand" to select.
      * **Head Gesture Control:** Use movements like "nod" and "shake" to confirm or cancel actions.
  * **Cloud Sync (Planned):** Your documents are saved and synchronized in real-time across devices via Firebase.
  * **Offline Mode:** Keep working without an internet connection; your changes will be synced as soon as you reconnect.

## 🛠️ Tech Stack

This project uses a set of modern technologies to ensure performance, security, and a great developer experience.

  * **Application Framework:** [Tauri](https://tauri.app/) - Allows creating lightweight and secure desktop applications with a Rust backend and a frontend based on web technologies.
  * **Backend Language:** [Rust](https://www.rust-lang.org/) - For performance, memory safety, and low-level control in the main process.
  * **Frontend:** Flexible (React, Vue, Svelte, etc.) - The initial scaffolding allows for the choice of your preferred framework with TypeScript.
  * **Computer Vision (CV):**
      * [OpenCV](https://opencv.org/) - For classic CV operations, such as image preprocessing and motion analysis.
      * [ONNX Runtime](https://onnxruntime.ai/) - To run AI models efficiently and cross-platform, performing robust detection of anchors (hands, face) and complex pose analysis.
  * **Cloud Services (Backend):** [Firebase](https://firebase.google.com/)
      * **Authentication:** Firebase Authentication
      * **Database:** Cloud Firestore (for real-time sync and offline mode)
      * **File Storage:** Cloud Storage

## 🏛️ Architecture

EasyFlow Editor is a native desktop application, not a packaged website.

1.  **Core (Rust):** The main process is written in Rust. It manages the window, application state, and all heavy business logic, including the computer vision pipeline.
2.  **Interface (WebView):** The UI is rendered in a native OS WebView, enabling the use of modern web technologies to create a rich and responsive interface.
3.  **Communication:** Communication between the frontend (JavaScript/TypeScript) and the backend (Rust) is done securely and efficiently through an interoperability bridge provided by Tauri.
4.  **Hybrid CV Pipeline:** To balance performance and accuracy, we adopt a hybrid approach:
      * A lightweight AI model (via ONNX) robustly detects the "anchors" (hands, face).
      * OpenCV algorithms track and analyze simple motion within these regions of interest (ROI).
      * A more detailed AI pose estimation model is invoked only when necessary to recognize complex gestures.

## 🚀 Getting Started (Local Development)

Follow these steps to set up and run the project on your local machine.

### Prerequisites

Ensure you have the following installed:

1.  **Rust and Cargo:** `curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh`
2.  **Node.js and Package Manager:** We recommend `pnpm`.
3.  **Tauri Prerequisites:** Follow the [official Tauri guide](https://tauri.app/v1/guides/getting-started/prerequisites) to install the development dependencies for your operating system (essential for compilation).

### Installation

1.  **Clone the repository:**

    ```sh
    git clone [https://github.com/YOUR_USERNAME/easyflow-editor.git](https://github.com/YOUR_USERNAME/easyflow-editor.git)
    cd easyflow-editor
    ```

2.  **Install frontend dependencies:**

    ```sh
    pnpm install
    ```

3.  **Set up Firebase (crucial step):**

      * Follow the instructions in the [Firebase Setup](#firebase-setup) section below.

4.  **Run the development environment:**

    ```sh
    pnpm tauri dev
    ```

    This will open the application window and automatically rebuild the backend and frontend whenever files are changed.

### Firebase Setup

For cloud features (login, sync) to work, you need to connect the project to your own Firebase instance.

1.  Go to the [Firebase Console](https://console.firebase.google.com/) and create a new project.
2.  Inside your project, enable the following services:
      * **Authentication:** Go to the "Authentication" tab and enable the sign-in providers you want (e.g., "Email/Password", "Google").
      * **Firestore Database:** Create a new Firestore database. Start in test mode to facilitate development.
      * **Storage:** Enable Cloud Storage.
3.  Go to "Project Settings" and, in the "General" tab, find your web configuration credentials (`firebaseConfig`).
4.  Create a `.env` file in the project root and add your credentials. The Rust backend will be configured to read this file and securely expose the credentials to the frontend.
    ```env
    # .env
    VITE_FIREBASE_API_KEY="YOUR_API_KEY"
    VITE_FIREBEASE_AUTH_DOMAIN="YOUR_AUTH_DOMAIN"
    # ...and so on for all keys in the firebaseConfig object.
    ```

## 💻 Recommended Development Environment

We recommend using **Visual Studio Code** with the extensions suggested in the `.vscode/extensions.json` file. Upon opening the project, VS Code will notify you to install the recommended extensions, which include:

  * `rust-analyzer`: Full language support for Rust.
  * `Tauri`: Commands and integration with Tauri.
  * `CodeLLDB`: For debugging Rust code.
  * And other tools for frontend code quality.

## 🗺️ Roadmap

  - [x] Project scaffolding with Tauri, Rust, and Frontend.
  - [ ] Base Computer Vision module (camera capture and display).
  - [ ] Implementation of head gestures (nod, shake).
  - [ ] Implementation of hand gestures (MVP: pinch, swipe, open/close).
  - [ ] Integration with Firebase Authentication for user login.
  - [ ] Block editor structure in the frontend.
  - [ ] Document synchronization with Firestore.
  - [ ] Image storage in Cloud Storage.

## 🤝 Contributing

Contributions are what make the open-source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1.  Fork the Project
2.  Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3.  Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4.  Push to the Branch (`git push origin feature/AmazingFeature`)
5.  Open a Pull Request

## 📄 License

Distributed under the MIT License. See `LICENSE` for more information.