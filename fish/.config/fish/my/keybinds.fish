function fish_user_key_bindings
    # Принятие автодополнения (autosuggestion) через Ctrl+L
    bind \cl accept-autosuggestion

    # Принять только одно слово (Alt + L)
    bind \el forward-word

    # Fzf
    bind \cf "_fzf_search_directory; kitty +kitten icat --clear"
end

