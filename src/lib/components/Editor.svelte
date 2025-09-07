<script lang="ts">
  import { tick } from 'svelte';
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

  async function handleDeleteBlock(event: CustomEvent<{ id: string }>) {
    const { id } = event.detail;
    const index = document.findIndex(b => b.id === id);

    if (index !== -1) {
      // Prevent deleting the last block
      if (document.length === 1) {
        return;
      }

      const newDocument = document.filter(b => b.id !== id);
      
      // Determine which block to focus next
      const focusIndex = Math.max(0, index - 1);
      const blockToFocus = newDocument[focusIndex];

      if (blockToFocus) {
        newDocument.forEach(b => b.autofocus = false);
        blockToFocus.autofocus = true;
      }
      
      document = newDocument;

      // Wait for the DOM to update, then focus the correct element
      await tick();
      const elementToFocus = document.getElementById(blockToFocus.id);
      if (elementToFocus) {
        elementToFocus.focus();
      }
    }
  }
</script>

<div class="editor-container">
  {#each document as block (block.id)}
    <BlockRenderer 
      {block} 
      on:addBlockAfter={handleAddBlockAfter}
      on:delete={handleDeleteBlock}
    />
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
