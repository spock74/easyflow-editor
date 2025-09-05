// src/main.rs

fn main() {
    tauri::Builder::default()
        // Ao passar a macro diretamente, o compilador entende
        // o tipo esperado pela função .invoke_handler()
        .invoke_handler(tauri::generate_handler![
            core::commands::greet
        ])
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}