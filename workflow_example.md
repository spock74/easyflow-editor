# This workflow focuses on a smooth development experience, from initial setup to final build, leveraging the best features of each technology.

-----

## \#\# 1. Project Setup 🚀

First, you'll want to create your project using the official `create-tauri-app` tool. This ensures everything is configured correctly from the start.

1.  Open your terminal and run the following command. You can use `npm`, `pnpm`, or `yarn`.

    ```bash
    # Using pnpm (recommended)
    pnpm create tauri-app

    # Or using npm
    npm create tauri-app@latest
    ```

2.  The command-line interface will ask you a few questions. Make these selections:

      * **What is your app name?** → Enter your project name.
      * **Choose your package manager:** → Select `pnpm`, `npm`, or `yarn`.
      * **Choose your UI template:** → Select **Vite**.
      * **Choose your Vite flavor:** → Select **TypeScript**.

This process creates a new directory with a complete project structure, including the frontend (`src`) and backend (`src-tauri`).

-----

## \#\# 2. VS Code Configuration ⚙️

To get the best experience in VS Code, you need a few key extensions. They provide syntax highlighting, code completion, error checking, and debugging.

Go to the Extensions view (`Ctrl+Shift+X`) and install these:

  * **`Tauri`**: The official extension for Tauri. Adds commands to the command palette.
  * **`rust-analyzer`**: Essential for Rust development. It's the official language server and provides incredible code completion, inline error checking, and navigation.
  * **`CodeLLDB`**: The best extension for debugging the Rust backend on VS Code.
  * **`Vite`**: Official extension for Vite. Provides better integration and helps with configuration.

-----

## \#\# 3. The Development Workflow 💻

This is your day-to-day process for coding.

### Running the Development Server

The most important command is `tauri dev`. This command does two things at once:

1.  It starts the **Vite dev server** for your TypeScript frontend, giving you hot-reloading for UI changes.
2.  It builds and runs your **Rust backend** in debug mode.

<!-- end list -->

```bash
# Navigate into your new project folder
cd your-app-name

# Start the development server
pnpm tauri dev
```

Your desktop application window will open. Now you can start coding.

### Frontend (TypeScript + Vite)

  * **Location**: All your frontend code is in the `src/` directory.
  * **Process**: When you save changes to a `.ts`, `.tsx`, or `.css` file, Vite will instantly update the UI in your app window. **No restart needed.**

### Backend (Rust)

  * **Location**: Your Rust code lives in the `src-tauri/` directory. The main file is `src-tauri/src/main.rs`.
  * **Process**: When you save changes to a `.rs` file, the `tauri dev` process will automatically detect it and **recompile your Rust backend**. The app will then restart with the new backend code.

### Communicating Between Frontend and Backend (Tauri Commands)

This is the core of Tauri. You expose Rust functions to your TypeScript frontend.

1.  **In Rust (`src-tauri/src/main.rs`)**:
    Define a function and add the `#[tauri::command]` attribute.

    ```rust
    // In src-tauri/src/main.rs

    // This makes the function available to the frontend
    #[tauri::command]
    fn greet(name: &str) -> String {
        format!("Hello, {}! You've been greeted from Rust!", name)
    }

    fn main() {
        tauri::Builder::default()
            // This is where you register the command
            .invoke_handler(tauri::generate_handler![greet])
            .run(tauri::generate_context!())
            .expect("error while running tauri application");
    }
    ```

2.  **In TypeScript (`src/main.ts` or any component file)**:
    Use the `invoke` function from the `@tauri-apps/api` library to call your Rust command.

    ```typescript
    // In a frontend file, e.g., src/main.ts
    import { invoke } from '@tauri-apps/api/tauri';

    async function sayHello() {
      // 'greet' is the name of the Rust function
      // The second argument is an object with the function arguments
      const message: string = await invoke('greet', { name: 'World' });
      console.log(message); // Logs: "Hello, World! You've been greeted from Rust!"
    }

    sayHello();
    ```

-----

## \#\# 4. Debugging 🐛

You need to debug both the frontend and the backend separately.

### Frontend Debugging

This is easy. Just **right-click** inside your Tauri app window and select **"Inspect Element"**. This will open the familiar browser dev tools, where you can inspect the DOM, check the console for logs, and debug your TypeScript.

### Backend (Rust) Debugging

This requires `CodeLLDB` and a small configuration.

1.  Create a file: `.vscode/launch.json`.

2.  Paste the following configuration into it. This tells VS Code how to attach the debugger to your Rust application.

    ```json
    {
      "version": "0.2.0",
      "configurations": [
        {
          "type": "lldb",
          "request": "launch",
          "name": "Tauri App Debug",
          "cargo": {
            "args": [
              "build",
              "--manifest-path=./src-tauri/Cargo.toml"
            ]
          },
          "program": "./src-tauri/target/debug/your-app-name", // IMPORTANT: Change "your-app-name"
          "cwd": "${workspaceFolder}"
        }
      ]
    }
    ```

    **Important**: Replace `your-app-name` in the `"program"` line with the actual name of your app (look for the executable file in `src-tauri/target/debug/`).

3.  Now, you can set breakpoints in your `.rs` files, go to the "Run and Debug" panel in VS Code (`Ctrl+Shift+D`), and click the green play button to start debugging.

-----

## \#\# 5. Building for Production 📦

When you're ready to create a distributable application file (like a `.exe` or `.app`), run the build command.

```bash
pnpm tauri build
```

This command will:

1.  Build your frontend with Vite in production mode (minified and optimized).
2.  Compile your Rust backend in release mode (highly optimized).
3.  Bundle them together into a single, native executable for your operating system.

The final files will be located in `src-tauri/target/release/bundle/`.