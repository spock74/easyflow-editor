<script lang="ts">
  import type { Block } from '../types';

  export let block: Block;
</script>

<h1
  contenteditable="true"
  bind:textContent={block.content}
  class="block"
></h1>