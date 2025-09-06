<script lang="ts">
    import { onMount } from 'svelte';
    import { invoke } from '@tauri-apps/api/core';
    import { listen } from '@tauri-apps/api/event';

    // Variável reativa para armazenar a string Base64 do frame
    let frameSrc = '';

    onMount(async () => {
        // 1. Inicia o listener para o evento 'new-frame' vindo do Rust
        const unlisten = await listen('new-frame', (event) => {
            // Atualiza a variável com o novo frame recebido
            frameSrc = event.payload as string;
        });

        // 2. Chama o comando Rust para iniciar a captura da webcam
        await invoke('start_stream');

        // 3. Retorna a função de cleanup que será chamada quando o componente for destruído
        return () => {
            unlisten();
        };
    });
</script>

<main class="container">
    <h1>Webcam Stream via Rust + OpenCV</h1>
    <div class="stream-container">
        {#if frameSrc}
            <img src={frameSrc} alt="Webcam Stream" width="640" height="480" />
        {:else}
            <p>Aguardando stream da webcam...</p>
        {/if}
    </div>
</main>

<style>
    .container {
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        text-align: center;
    }
    .stream-container {
        width: 640px;
        height: 480px;
        border: 2px solid #333;
        background-color: #000;
        display: flex;
        justify-content: center;
        align-items: center;
        color: white;
    }
    img {
        max-width: 100%;
        height: auto;
    }
</style>