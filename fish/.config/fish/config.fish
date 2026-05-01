source /usr/share/cachyos-fish-config/cachyos-config.fish

set -g fish_key_bindings fish_vi_key_bindings
set -g fish_sequence_key_delay_ms 500

if status is-interactive
    source ~/.config/fish/my/keybinds.fish
    source ~/.config/fish/my/fzf.fish
end

if status is-interactive
    zoxide init fish | source
end

function y
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	yazi $argv --cwd-file="$tmp"
	if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
		builtin cd -- "$cwd"
	end
	rm -f -- "$tmp"
end


# pnpm
set -gx PNPM_HOME "/home/xalk/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
