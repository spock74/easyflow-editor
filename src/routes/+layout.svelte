<svelte:head>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
</svelte:head>

<script lang="ts">
  import Sidebar from '$lib/components/Sidebar.svelte';
  import '../app.css';

  let isSidebarOpen = $state(true);
  let isPinned = $state(true);

  function togglePin() {
    isPinned = !isPinned;
    if (isPinned) {
      isSidebarOpen = true;
    }
  }

  function handleSidebarEnter() {
    if (!isPinned) {
      isSidebarOpen = true;
    }
  }
</script>

<div class="app-layout">
  <div class="sidebar-trigger-area" on:mouseenter={handleSidebarEnter}></div>

  <Sidebar bind:isSidebarOpen {isPinned} {togglePin} />

  <main class="content-area" class:sidebar-pinned={isPinned}>
    <slot />
  </main>
</div>

<style>
  .app-layout {
    display: flex;
    height: 100vh;
    width: 100vw;
    overflow: hidden;
  }

  .sidebar-trigger-area {
    position: fixed;
    top: 0;
    left: 0;
    width: 15px;
    height: 100%;
    z-index: 20;
  }

  .content-area {
    flex-grow: 1;
    height: 100vh;
    overflow-y: auto;
    transition: margin-left 0.3s ease-in-out;
  }

  .content-area.sidebar-pinned {
    margin-left: var(--sidebar-width);
  }
</style>
