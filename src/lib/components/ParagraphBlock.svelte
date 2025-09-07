<script lang="ts">
  import { onMount } from 'svelte';
  import { createEventDispatcher } from 'svelte';
  import type { Block } from '../types';

  export let block: Block;

  const dispatch = createEventDispatcher<{ addBlockAfter: { id: string } }>();

  let element: HTMLParagraphElement;

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
</script>

<p
  id={block.id}
  bind:this={element}
  contenteditable="true"
  bind:textContent={block.content}
  on:keydown={handleKeydown}
  class="block"
>
</p>
