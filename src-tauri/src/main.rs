// src-tauri/src/main.rs

mod core;
mod cv;

fn main() {
    tauri::Builder::default()
        .invoke_handler(tauri::generate_handler![
            core::commands::greet,
            core::commands::show_opencv_window,
            core::commands::start_stream
        ])
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}