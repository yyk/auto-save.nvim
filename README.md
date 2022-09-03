<p align="center">
  <h2 align="center">🧶 simply-auto-save.nvim</h2>
</p>

<p align="center">
	Automatically save your changes in NeoVim.
	A heavy handed fork of Pocco81/simply-auto-save.nvim that aims to simplify configuration. (We have too many plugins with too many options already, let's just go with sane defaults.)
</p>

<p align="center">
	<a href="https://github.com/yyk/simply-auto-save.nvim/stargazers">
		<img alt="Stars" src="https://img.shields.io/github/stars/yyk/simply-auto-save.nvim?style=for-the-badge&logo=starship&color=C9CBFF&logoColor=D9E0EE&labelColor=302D41"></a>
	<a href="https://github.com/yyk/simply-auto-save.nvim/issues">
		<img alt="Issues" src="https://img.shields.io/github/issues/yyk/simply-auto-save.nvim?style=for-the-badge&logo=bilibili&color=F5E0DC&logoColor=D9E0EE&labelColor=302D41"></a>
	<a href="https://github.com/yyk/simply-auto-save.nvim">
		<img alt="Repo Size" src="https://img.shields.io/github/repo-size/yyk/simply-auto-save.nvim?color=%23DDB6F2&label=SIZE&logo=codesandbox&style=for-the-badge&logoColor=D9E0EE&labelColor=302D41"/></a>
</p>

&nbsp;

### 📋 Features

- automatically save your changes so the world doesn't collapse
- simple customization:
	- skip certain filetypes/buftypes
	- events that trigger simply-auto-save
  - debounce the save with a delay

&nbsp;

### 📚 Requirements

-   Neovim >= 0.5.0

&nbsp;

### 📦 Installation

Install the plugin with your favourite package manager:

<details>
	<summary><a href="https://github.com/wbthomason/packer.nvim">Packer.nvim</a></summary>

```lua
use({
	"yyk/simply-auto-save.nvim",
	config = function()
		 require("simply-auto-save").setup {
			-- your config goes here
			-- or just leave it empty :)
		 }
	end,
})
```

</details>

<details>
	<summary><a href="https://github.com/junegunn/vim-plug">vim-plug</a></summary>

```vim
Plug 'Pocco81/simply-auto-save.nvim'
lua << EOF
	require("simply-auto-save").setup {
		-- your config goes here
		-- or just leave it empty :)
	}
EOF
```

</details>

&nbsp;

### ⚙️ Configuration

**simply-auto-save** comes with the following defaults:

```lua
{
	enabled = true, -- start simply-auto-save when the plugin is loaded (i.e. when your package manager loads it)
	trigger_events = {"InsertLeave", "BufHidden"}, -- vim events that trigger simply-auto-save. See :h events
	ignore_filetypes = {}, -- file types to disable auto save
	ignore_buftypes = {}, -- buf types to disable auto save
	debounce_delay = 500, -- saves the file at most every `debounce_delay` milliseconds
}
```

&nbsp;

### 🪴 Usage

Besides running simply-auto-save at startup (if you have `enabled = true` in your config), you may as well:

- `AutoSaveToggle`: toggle simply-auto-save

&nbsp;
