<script lang="ts">
  import type { Block } from '../types';

  export let block: Block;
</script>

<p
  contenteditable="true"
  bind:textContent={block.content}
  class="block"
>
</p>