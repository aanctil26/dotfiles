# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/.bash_profile

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Disable history number in prompt
setopt NO_PROMPT_BANG

plugins=(git zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# Source secrets file if it exists
[[ -f ~/.secrets ]] && source ~/.secrets

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=cyan'

# AWS Profile Switchers
alias aws-researcher='export AWS_PROFILE=researcher && echo "✓ Switched to AWS profile: researcher"'
alias aws-product='export AWS_PROFILE=product && echo "✓ Switched to AWS profile: product"'
alias aws-jordan='export AWS_PROFILE=jordan && echo "✓ Switched to AWS profile: jordan"'
alias aws-default='unset AWS_PROFILE && echo "✓ Switched to default AWS profile"'
alias aws-whoami='echo "Current profile: ${AWS_PROFILE:-default}" && aws sts get-caller-identity'

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
