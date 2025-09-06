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