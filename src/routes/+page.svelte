<script lang="ts">
  import BlockRenderer from '$lib/components/BlockRenderer.svelte';
  import type { Block } from '$lib/types';

  let document: Block[] = $state([
    { id: '1', type: 'heading', content: 'Bem-vindo ao EasyFlow Editor' },
    { id: '2', type: 'paragraph', content: 'Este é um parágrafo editável.' },
    { id: '3', type: 'paragraph', content: 'Clique em mim para editar o texto.' }
  ]);

  function handleBlockUpdate(event: CustomEvent<{ id: string; content: string }>) {
    const { id, content } = event.detail;
    const index = document.findIndex(b => b.id === id);
    if (index !== -1) {
      // Create a new array to trigger Svelte's reactivity
      const newDocument = [...document];
      newDocument[index] = { ...newDocument[index], content };
      document = newDocument;
    }
  }
</script>

<main class="container">
  <div class="editor">
    {#each document as block (block.id)}
      <BlockRenderer {block} on:update={handleBlockUpdate} />
    {/each}
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