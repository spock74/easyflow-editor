#[tauri::command]
pub fn greet(name: &str) -> String {
    format!("Olá, {}! Você foi chamado a partir do Rust!", name)
}
