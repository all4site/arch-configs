source /usr/share/cachyos-fish-config/cachyos-config.fish
set -g fish_key_bindings fish_vi_key_bindings
set -g fish_sequence_key_delay_ms 500

if status is-interactive
    source ~/.config/fish/my/keybinds.fish
    source ~/.config/fish/my/fzf.fish
end


