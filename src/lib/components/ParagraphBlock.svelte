<script lang="ts">
  import { createEventDispatcher } from 'svelte';
  import type { Block } from '../types';

  export let block: Block;

  const dispatch = createEventDispatcher<{ update: { id: string; content: string } }>();

  let element: HTMLElement;

  function handleInput() {
    if (element) {
      dispatch('update', {
        id: block.id,
        content: element.innerText,
      });
    }
  }
</script>

<p
  bind:this={element}
  contenteditable="true"
  on:input={handleInput}
  class="block"
>
  {block.content}
</p>
