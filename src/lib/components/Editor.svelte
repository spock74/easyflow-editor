<script lang="ts">
  import BlockRenderer from './BlockRenderer.svelte';
  import type { Block } from '../types';

  let document: Block[] = $state([
    { id: '1', type: 'heading', content: 'Bem-vindo ao EasyFlow Editor' },
    { id: '2', type: 'paragraph', content: 'Este é o seu novo editor. Pressione Enter para adicionar mais blocos.' }
  ]);

  function handleAddBlockAfter(event: CustomEvent<{ id: string }>) {
    const { id } = event.detail;
    const index = document.findIndex(b => b.id === id);

    if (index !== -1) {
      document.forEach(b => b.autofocus = false);

      const newBlock: Block = {
        id: crypto.randomUUID(),
        type: 'paragraph',
        content: '',
        autofocus: true
      };
      
      const newDocument = [...document];
      newDocument.splice(index + 1, 0, newBlock);
      document = newDocument;
    }
  }
</script>

<div class="editor-container">
  {#each document as block (block.id)}
    <BlockRenderer {block} on:addBlockAfter={handleAddBlockAfter} />
  {/each}
</div>

<style>
  .editor-container {
    width: 100%;
    max-width: 800px;
    margin: 0 auto;
    padding: 4rem 2rem;
    line-height: 1.7;
  }
</style>
