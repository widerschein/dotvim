#!/usr/bin/env python3

import os
import argparse
import subprocess
import shutil
import concurrent.futures
from pathlib import Path

PLUGINS = {
        "ack": "https://github.com/mileszs/ack.vim.git",
        "a": "https://github.com/vim-scripts/a.vim.git",
        "auto-pairs": "https://github.com/jiangmiao/auto-pairs.git",
        "bookmarks": "https://github.com/MattesGroeger/vim-bookmarks.git",
        "bufexplorer": "https://github.com/jlanzarotta/bufexplorer.git",
        "cmp-buffer": "https://github.com/hrsh7th/cmp-buffer.git",
        "cmp": "https://github.com/hrsh7th/nvim-cmp.git",
        "cmp-lsp": "https://github.com/hrsh7th/cmp-nvim-lsp.git",
        "cmp-path": "https://github.com/hrsh7th/cmp-path.git",
        "cmp-ultisnips": "https://github.com/quangnguyen30192/cmp-nvim-ultisnips.git",
        "codecompanion": "https://github.com/olimorris/codecompanion.nvim.git",
        "dirvish": "https://github.com/justinmk/vim-dirvish.git",
        "dispatch": "https://github.com/tpope/vim-dispatch.git",
        "everforest": "https://github.com/sainnhe/everforest.git",
        "fugitive": "https://github.com/tpope/vim-fugitive.git",
        "gitsigns": "https://github.com/lewis6991/gitsigns.nvim.git",
        "javascript": "https://github.com/pangloss/vim-javascript.git",
        "kanagawa": "https://github.com/rebelot/kanagawa.nvim.git",
        "lsp-config": "https://github.com/neovim/nvim-lspconfig.git",
        "lualine": "https://github.com/nvim-lualine/lualine.nvim.git",
        "nerdcommenter": "https://github.com/scrooloose/nerdcommenter.git",
        "none-ls": "https://github.com/nvimtools/none-ls.nvim.git",
        "plenary": "https://github.com/nvim-lua/plenary.nvim.git",
        "rainbow": "https://github.com/luochen1990/rainbow",
        "sensible": "https://github.com/tpope/vim-sensible.git",
        "sneak": "https://github.com/justinmk/vim-sneak.git",
        "snippets": "https://github.com/honza/vim-snippets.git",
        "speeddating": "https://github.com/tpope/vim-speeddating.git",
        "surround": "https://github.com/tpope/vim-surround.git",
        "tabular": "https://github.com/godlygeek/tabular.git",
        "tagbar": "https://github.com/majutsushi/tagbar.git",
        "telescope": "https://github.com/nvim-telescope/telescope.nvim.git",
        "ultisnips": "https://github.com/SirVer/ultisnips.git"
        }


def gitproc(cmd, cwd):
    return subprocess.run(
            cmd,
            text=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            cwd=cwd).stdout

def update(name, plugin_dir):
    print("* {} : Update\n{}".format(name, gitproc(["git", "pull", "--recurse-submodules", "--stat"], plugin_dir)))

def install(name, url, bundle_dir):
    print("* {} : Install \n{}".format(name, gitproc(["git", "clone", "--recursive", url, name], bundle_dir)))

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Manage Neovim plugins")
    parser.add_argument("what", help="Manage bundle", choices=["fetch", "prune"])
    args = parser.parse_args()

    if os.name == "nt":
        bundle_dir = Path.home() / "Neovim" / "share" / "nvim" / "runtime" / "pack" / "plugins" / "start"
    else:
        bundle_dir = Path.home() / ".vim" / "pack" / "plugins" / "start"

    if args.what == "fetch":
        bundle_dir.mkdir(parents=True, exist_ok=True)
        with concurrent.futures.ThreadPoolExecutor() as executor:
            for plug, url in PLUGINS.items():
                plugin_path = bundle_dir / plug
                if plugin_path.exists():
                    executor.submit(update, plug, plugin_path)
                else:
                    executor.submit(install, plug, url, bundle_dir)

    elif args.what == "prune":
        surplus_folders = [
                folder for folder in bundle_dir.iterdir()
                if not folder.stem in PLUGINS or folder.is_file()
                ]

        if len(surplus_folders):
            do_remove =  input("Remove {}? [y/n]".format(", ".join(sorted(f.stem for f in surplus_folders))))
            if "y" in do_remove:
                for folder in surplus_folders:
                    shutil.rmtree(folder)
        else:
            print("Nothing to prune")
