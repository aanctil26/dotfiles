
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/andrew/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/andrew/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/andrew/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/andrew/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export PATH=/opt/homebrew/bin:"/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
export PATH=/usr/local/bin:/opt/homebrew/bin:/opt/homebrew/bin:/opt/homebrew/sbin:/Users/andrew/anaconda3/bin:/condabin:"/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
. "$HOME/.cargo/env"
