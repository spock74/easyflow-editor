<script lang="ts">
  import HeadingBlock from './HeadingBlock.svelte';
  import ParagraphBlock from './ParagraphBlock.svelte';
  import type { Block } from '../types';

  export let block: Block;
</script>

{#if block.type === 'heading'}
  <HeadingBlock {block} on:update />
{:else if block.type === 'paragraph'}
  <ParagraphBlock {block} on:update />
{/if}
