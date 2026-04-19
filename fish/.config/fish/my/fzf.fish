# Exclude folder and add folder with .
set fzf_fd_opts --follow --hidden --max-depth 5 --exclude .git \
    --exclude .cache \
    --exclude .cargo \
    --exclude .gnupg \
    --exclude .local \
    --exclude .npm \
    --exclude .nv \
    --exclude .steam 


# Preview Image
set -gx fzf_directory_opts --preview '

set -l mime (file --mime-type -b {})

if string match -r "^image/" $mime
    chafa --format=kitty --animate=false  --size=30x15 {}
    kitty +kitten icat --clear {}
else
    bat --color=always --style=numbers {}
end'

