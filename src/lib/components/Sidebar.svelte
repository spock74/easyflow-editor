<script lang="ts">
  import { User, ChevronDown, FileText, Database, Search, Home, Inbox, Pin } from 'lucide-svelte';
  
  export let isSidebarOpen = true;
  export let isPinned = false;
  export let togglePin: () => void;

  function handleMouseLeave() {
    if (!isPinned) {
      isSidebarOpen = false;
    }
  }
</script>

<aside 
  class="sidebar" 
  class:closed={!isSidebarOpen}
  on:mouseleave={handleMouseLeave}
>
  <div class="user-section menu-item">
    <User size={20} />
    <span class="user-name">José's Notion</span>
    <button class="pin-button" on:click={togglePin} title="{isPinned ? 'Unpin sidebar' : 'Pin sidebar'}">
      <Pin size={16} class={isPinned ? 'pinned' : ''} />
    </button>
  </div>

  <div class="main-menu">
    <div class="menu-item">
      <Search size={18} />
      <span>Search</span>
    </div>
    <div class="menu-item">
      <Home size={18} />
      <span>Home</span>
    </div>
    <div class="menu-item">
      <Inbox size={18} />
      <span>Inbox</span>
    </div>
  </div>

  <div class="group-section">
    <div class="group-header">Favorites</div>
    <div class="document-item menu-item">
      <FileText size={16} />
      <span>Roadmap QMD Fase 2</span>
    </div>
  </div>

  <div class="group-section private">
    <div class="group-header">Private</div>
    <div class="document-item menu-item">
      <FileText size={16} />
      <span>Uma introdução à BERT-logia</span>
    </div>
    <div class="document-item menu-item">
      <FileText size={16} />
      <span>Anotações da Reunião de Synch</span>
    </div>
    <div class="document-item menu-item">
      <Database size={16} />
      <span>Meu Banco de Dados</span>
    </div>
  </div>
</aside>

<style>
  .sidebar {
    width: var(--sidebar-width);
    min-width: var(--sidebar-width);
    background-color: var(--bg-sidebar);
    padding: 0.5rem;
    height: 100vh;
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
    color: var(--text-primary);
    border-right: 1px solid var(--border-color);
    transition: transform 0.3s ease-in-out;
    position: fixed;
    left: 0;
    top: 0;
    z-index: 30;
    box-sizing: border-box;
  }

  .sidebar.closed {
    transform: translateX(-100%);
  }

  .menu-item {
    display: flex;
    align-items: center;
    gap: 0.8rem;
    padding: 0.5rem;
    border-radius: 5px;
    cursor: pointer;
    font-size: 0.9rem;
    font-weight: 500;
    transition: background-color 0.2s ease;
  }

  .menu-item:hover {
    background-color: var(--hover-bg);
  }

  .user-section {
    justify-content: space-between;
  }

  .user-name {
    flex-grow: 1;
    margin-left: 0.8rem;
  }

  .pin-button {
    padding: 4px;
    border-radius: 4px;
    display: flex;
    align-items: center;
    justify-content: center;
  }

  .pin-button:hover {
    background-color: var(--hover-bg);
  }

  .pin-button :global(svg) {
    color: var(--text-secondary);
    transition: transform 0.2s ease-in-out, color 0.2s ease-in-out;
  }

  .pin-button :global(svg.pinned) {
    transform: rotate(45deg);
    color: var(--text-primary);
  }

  .main-menu {
    border-bottom: 1px solid var(--border-color);
    padding-bottom: 0.5rem;
  }

  .group-header {
    font-size: 0.8rem;
    font-weight: 600;
    color: var(--text-secondary);
    margin-top: 1rem;
    margin-bottom: 0.5rem;
    padding: 0 0.5rem;
  }

  .group-section.private {
    flex-grow: 1;
  }
</style>
