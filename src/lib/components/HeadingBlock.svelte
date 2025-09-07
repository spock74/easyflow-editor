<script lang="ts">
  import { onMount } from 'svelte';
  import { createEventDispatcher } from 'svelte';
  import { Trash2 } from 'lucide-svelte';
  import type { Block } from '../types';

  export let block: Block;

  const dispatch = createEventDispatcher<{
    addBlockAfter: { id: string };
    delete: { id: string };
  }>();

  let element: HTMLHeadingElement;

  onMount(() => {
    if (block.autofocus) {
      element.focus();
    }
  });

  function handleKeydown(event: KeyboardEvent) {
    if (event.key === 'Enter') {
      event.preventDefault();
      dispatch('addBlockAfter', { id: block.id });
    }
  }

  function handleDelete() {
    dispatch('delete', { id: block.id });
  }
</script>

<div class="block-wrapper">
  <h1
    id={block.id}
    bind:this={element}
    contenteditable="true"
    bind:textContent={block.content}
    on:keydown={handleKeydown}
    class="block"
  ></h1>
  <button class="delete-button" on:click={handleDelete} title="Delete block">
    <Trash2 size={18} />
  </button>
</div>

<style>
  .block-wrapper {
    position: relative;
  }

  .block {
    outline: none;
  }

  .delete-button {
    position: absolute;
    top: 50%;
    right: 100%;
    transform: translateY(-50%);
    margin-right: 10px;
    background: none;
    border: none;
    cursor: pointer;
    color: var(--text-secondary);
    opacity: 0;
    transition: opacity 0.2s ease-in-out;
    padding: 4px;
    border-radius: 4px;
    display: flex;
    align-items: center;
    justify-content: center;
  }

  .block-wrapper:hover .delete-button {
    opacity: 1;
  }

  .delete-button:hover {
    background-color: var(--hover-bg);
    color: var(--danger-color);
  }
</style>
