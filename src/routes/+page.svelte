<script lang="ts">
  import BlockRenderer from '$lib/components/BlockRenderer.svelte';
  import type { Block } from '$lib/types';

  let document: Block[] = $state([
    { id: '1', type: 'heading', content: 'Bem-vindo ao EasyFlow Editor' },
    { id: '2', type: 'paragraph', content: 'Este é um parágrafo editável.' },
    { id: '3', type: 'paragraph', content: 'Clique em mim para editar o texto.' }
  ]);

  function addBlock() {
    const newBlock: Block = {
      id: crypto.randomUUID(),
      type: 'paragraph',
      content: ''
    };
    document = [...document, newBlock];
  }
</script>

<main class="container">
  <div class="editor">
    {#each document as block (block.id)}
      <BlockRenderer {block} />
    {/each}

    <div class="actions">
      <button on:click={addBlock}>Adicionar Parágrafo</button>
    </div>
  </div>
</main>

<style>
  .container {
    display: flex;
    justify-content: center;
    padding: 2rem;
  }

  .editor {
    width: 100%;
    max-width: 800px;
    line-height: 1.6;
  }

  .actions {
    text-align: center;
    margin-top: 2rem;
  }

  button {
    padding: 0.5rem 1rem;
    font-size: 1rem;
    cursor: pointer;
    border: 1px solid #ccc;
    border-radius: 4px;
    background-color: #f0f0f0;
  }

  /* Estilos globais para os blocos editáveis */
  :global(.block) {
    outline: none;
    cursor: text;
  }

  :global(.block:focus) {
    background-color: #f0f0f0; /* Um leve destaque ao focar */
  }

  :global(h1.block) {
    font-size: 2.2em;
    font-weight: 700;
    margin-bottom: 1em;
  }

  :global(p.block) {
    font-size: 1.1em;
    margin-bottom: 1em;
  }
</style>
