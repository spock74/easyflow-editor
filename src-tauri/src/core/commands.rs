// src-tauri/src/core/commands.rs

use std::thread;
use base64::{engine::general_purpose, Engine as _};
use opencv::prelude::*; // For VideoCaptureTraitConst, VideoCaptureTrait, MatTraitConst
use tauri::Emitter;     // For window.emit()
use crate::cv;          // For show_opencv_window

#[tauri::command]
pub fn greet(name: &str) -> String {
    format!("Olá, {}! Você foi chamado a partir do Rust!", name)
}

#[tauri::command]
pub fn show_opencv_window() {
    if let Err(e) = cv::processing::show_test_window() {
        eprintln!("Erro ao exibir a janela do OpenCV: {:?}", e);
    }
}

#[tauri::command]
pub fn start_stream(window: tauri::Window) {
    thread::spawn(move || {
        let mut cam = match opencv::videoio::VideoCapture::new(0, opencv::videoio::CAP_ANY) {
            Ok(cam) => cam,
            Err(e) => {
                eprintln!("Erro ao abrir a webcam: {:?}", e);
                return;
            }
        };

        if !cam.is_opened().unwrap_or(false) { // Now should work
            eprintln!("Não foi possível abrir a webcam.");
            return;
        }

        let mut frame = opencv::core::Mat::default();

        loop {
            match cam.read(&mut frame) { // Now should work
                Ok(true) => {
                    if frame.empty() { // Now should work
                        continue;
                    }

                    let mut buf = opencv::core::Vector::new();
                    let params = opencv::core::Vector::new();
                    if opencv::imgcodecs::imencode(".jpg", &frame, &mut buf, &params).unwrap_or(false) {
                        let base64_str = general_purpose::STANDARD.encode(buf.as_slice());
                        let data_url = format!("data:image/jpeg;base64,{}", base64_str);

                        window.emit("new-frame", data_url).unwrap(); // Now should work
                    }
                },
                _ => {
                    break;
                }
            }

            thread::sleep(std::time::Duration::from_millis(33));
        }
    });
}
