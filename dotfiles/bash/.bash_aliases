# Common aliases for bash
# This file is sourced by .bashrc

# ===== Navigation =====
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# ===== ls variants =====
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# ===== Safety defaults =====
alias mkdir='mkdir -p'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# ===== grep =====
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# ===== Git =====
alias gst='git status'
alias gss='git status'
alias gcm='git commit -m'
alias ga='git add'
alias gco='git checkout'
alias gp='git push'
alias gl='git log --oneline -10'

# ===== Docker =====
alias dex='docker exec'
alias dexe='docker exec -it'              # Interactive exec
alias dst='docker stats'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias dpsq='docker ps -q'                  # Only IDs
alias drst='docker restart'
alias drm='docker rm'
alias dlogs='docker logs -f'
alias dstop='docker stop'
alias dstart='docker start'
alias dpull='docker pull'
alias dbuild='docker build'
alias dcomp='docker compose'
alias dcompup='docker compose up -d'
alias dcompdown='docker compose down'

# ===== System =====
alias swapreset='sudo swapoff -a && sleep 3 && sudo swapon -a'
alias swapresetwait='sudo swapoff -a && sleep 15 && sudo swapon -a'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# ===== Package Management (uncomment as needed) =====
alias update='sudo apt update && sudo apt upgrade'  # Debian/Ubuntu
# alias update='sudo pacman -Syu'                      # Arch
