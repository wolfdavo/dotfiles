#!/bin/bash

# Cheat sheet for tmux and neovim keybindings
cheat() {
  local blue=$'\033[1;34m'
  local cyan=$'\033[0;36m'
  local yellow=$'\033[1;33m'
  local green=$'\033[0;32m'
  local reset=$'\033[0m'
  local dim=$'\033[2m'

  echo "
${blue}══════════════════════════════════════════════════════════════════════════════${reset}
${yellow}  TMUX${reset}  ${dim}Prefix = Ctrl+Space${reset}
${blue}══════════════════════════════════════════════════════════════════════════════${reset}

${cyan}Sessions & Windows${reset}
  ${green}c${reset}         New window (same path)     ${green}n/p${reset}       Next/prev window
  ${green}0-9${reset}       Go to window               ${green}w${reset}         List windows
  ${green},${reset}         Rename window              ${green}\$${reset}         Rename session
  ${green}s${reset}         List sessions              ${green}d${reset}         Detach

${cyan}Panes${reset}
  ${green}\\\\${reset}         Split horizontal           ${green}-${reset}         Split vertical
  ${green}h/j/k/l${reset}   Resize pane                ${green}m${reset}         Maximize/restore pane
  ${green}x${reset}         Kill pane                  ${green}z${reset}         Zoom pane

${cyan}Copy Mode${reset} ${dim}(Prefix + [)${reset}
  ${green}v${reset}         Begin selection            ${green}y${reset}         Copy to clipboard
  ${green}Prefix+P${reset}  Paste

${cyan}Plugins${reset}
  ${green}Ctrl+s${reset}    Save session               ${green}Ctrl+r${reset}    Restore session
  ${green}I${reset}         Install plugins            ${green}r${reset}         Reload config

${blue}══════════════════════════════════════════════════════════════════════════════${reset}
${yellow}  NEOVIM${reset}  ${dim}Leader = Space${reset}
${blue}══════════════════════════════════════════════════════════════════════════════${reset}

${cyan}General${reset}
  ${green}<Esc><Esc>${reset}   Clear search             ${green}<leader>w${reset}   Save
  ${green}<leader>q${reset}    Quit                     ${green}<leader>d${reset}   Show diagnostic
  ${green}]d / [d${reset}      Next/prev diagnostic     ${green}K${reset}           Hover docs

${cyan}Navigation${reset}
  ${green}Ctrl+d/u${reset}    Scroll down/up (center)  ${green}n/N${reset}         Find next/prev (center)
  ${green}Ctrl+h/j/k/l${reset} Navigate splits

${cyan}Windows & Buffers${reset}
  ${green}<leader>v${reset}    Vertical split           ${green}<leader>h${reset}   Horizontal split
  ${green}<leader>se${reset}   Equalize splits          ${green}<leader>xs${reset}  Close split
  ${green}<Tab>/<S-Tab>${reset} Next/prev buffer        ${green}<leader>x${reset}   Close buffer
  ${green}<leader>b${reset}    New buffer               ${green}Arrows${reset}      Resize splits

${cyan}Tabs${reset}
  ${green}<leader>to${reset}   New tab                  ${green}<leader>tx${reset}  Close tab
  ${green}<leader>tn/tp${reset} Next/prev tab

${cyan}Telescope${reset} ${dim}(fuzzy finder)${reset}
  ${green}<leader>sf${reset}   Find files               ${green}<leader>sg${reset}  Live grep
  ${green}<leader>sw${reset}   Search word under cursor ${green}<leader><leader>${reset} Find buffers
  ${green}<leader>sh${reset}   Help tags                ${green}<leader>sk${reset}  Keymaps
  ${green}<leader>sd${reset}   Diagnostics              ${green}<leader>sr${reset}  Resume last
  ${green}<leader>s.${reset}   Recent files             ${green}<leader>/${reset}   Fuzzy in buffer
  ${dim}In picker: Ctrl+j/k move, Ctrl+l select${reset}

${cyan}NeoTree${reset} ${dim}(file explorer)${reset}
  ${green}<leader>e${reset}    Toggle explorer          ${green}\\\\${reset}          Reveal file
  ${green}<leader>ngs${reset}  Git status float
  ${dim}In tree:${reset} ${green}a${reset} add  ${green}A${reset} add dir  ${green}d${reset} delete  ${green}r${reset} rename  ${green}y${reset} copy  ${green}p${reset} paste
          ${green}l${reset}/${green}<CR>${reset} open  ${green}s${reset} vsplit  ${green}S${reset} split  ${green}P${reset} preview  ${green}H${reset} hidden  ${green}q${reset} close

${cyan}LSP${reset}
  ${green}gd${reset}          Go to definition         ${green}gr${reset}          Go to references
  ${green}gI${reset}          Go to implementation     ${green}gD${reset}          Go to declaration
  ${green}<leader>D${reset}   Type definition          ${green}<leader>rn${reset}  Rename symbol
  ${green}<leader>ca${reset}  Code action              ${green}<leader>ds${reset}  Document symbols
  ${green}<leader>ws${reset}  Workspace symbols

${cyan}Visual Mode${reset}
  ${green}</>${reset}         Indent (stay in visual)  ${green}p${reset}           Paste (keep register)

${cyan}Claude Code${reset} ${dim}(IDE integration)${reset}
  ${green}<leader>cca${reset} Add file to context      ${green}<leader>ccs${reset} Send selection (visual)
  ${green}<leader>ccd${reset} Accept diff              ${green}<leader>ccD${reset} Deny diff

${cyan}SlashMD${reset} ${dim}(Markdown editing - active in .md files)${reset}
  ${green}<leader>sm${reset}  Toggle render view       ${green}]b / [b${reset}    Next/prev block
  ${green}<Tab>${reset}       Toggle fold/checkbox     ${green}<leader>bt${reset}  Transform block type
  ${green}<leader>bd${reset}  Delete block             ${green}<leader>bk/bj${reset} Move block up/down
  ${green}<leader>bh${reset}  Insert heading           ${green}<leader>bc${reset}  Insert code block
  ${green}<leader>bl${reset}  Insert bullet list       ${green}<leader>bn${reset}  Insert callout
  ${green}<leader>mb${reset}  Toggle bold              ${green}<leader>mi${reset}  Toggle italic
  ${green}<leader>mc${reset}  Toggle inline code       ${green}<leader>ml${reset}  Insert link
  ${dim}Insert mode:${reset} ${green}/${reset} slash menu (line start)  ${green}<Tab>/<S-Tab>${reset} indent/outdent list

${blue}══════════════════════════════════════════════════════════════════════════════${reset}
${yellow}  SHELL COMMANDS${reset}
${blue}══════════════════════════════════════════════════════════════════════════════${reset}

${cyan}Dev Environment${reset}
  ${green}dev${reset}         Open NeoVim + Claude + Terminal (3 panes)
  ${green}dev2${reset}        Open NeoVim + Claude (2 panes)

${blue}══════════════════════════════════════════════════════════════════════════════${reset}
"
}
