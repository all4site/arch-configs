function fish_user_key_bindings
    # Бинды для режима вставки (insert mode)
    bind -M insert \cl accept-autosuggestion
    bind -M insert \el forward-word

    # Принятие автодополнения (autosuggestion) через Ctrl+L
    bind -M default \cl accept-autosuggestion

    # Переход в нормальный режим по 'jk '
    bind -M insert -m default jk backward-char

    # Принять только одно слово (Alt + L)
    bind \el forward-word

    # Fzf
    bind -M insert \cf "_fzf_search_directory; kitty +kitten icat --clear"
    bind \cf "_fzf_search_directory; kitty +kitten icat --clear"
end

