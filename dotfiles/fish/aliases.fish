# Common aliases for fish shell
# Syntax: alias name 'command'

# ===== Navigation =====
alias .. 'cd ..'
alias ... 'cd ../..'
alias .... 'cd ../../..'

# ===== ls variants =====
alias ll 'ls -alF'
alias la 'ls -A'
alias l 'ls -CF'

# ===== Safety defaults =====
alias mkdir 'mkdir -p'
alias cp 'cp -i'
alias mv 'mv -i'
alias rm 'rm -i'

# ===== grep =====
alias grep 'grep --color=auto'
alias fgrep 'fgrep --color=auto'
alias egrep 'egrep --color=auto'

# ===== Git =====
alias gst 'git status'
alias gss 'git status'
alias gcm 'git commit -m'
alias ga 'git add'
alias gco 'git checkout'
alias gp 'git push'
alias gpl 'git pull'
alias gbr 'git branch'
alias gl 'git log --oneline -10'

# ===== Docker =====
alias dex 'docker exec'
alias dexe 'docker exec -it'
alias dst 'docker stats'
alias dps 'docker ps'
alias dpsa 'docker ps -a'
alias dpsq 'docker ps -q'
alias drst 'docker restart'
alias drm 'docker rm'
alias dlogs 'docker logs -f'
alias dstop 'docker stop'
alias dstart 'docker start'
alias dpull 'docker pull'
alias dbuild 'docker build'
alias dcomp 'docker compose'
alias dcompup 'docker compose up -d'
alias dcompdown 'docker compose down'
alias dstats 'docker stats'

# ===== System =====
alias swapreset 'sudo swapoff -a && sleep 3 && sudo swapon -a'
alias swapresetwait 'sudo swapoff -a && sleep 15 && sudo swapon -a'

# ===== Custom =====
alias connect 'ssh charles@Victus-Server || ssh charles@192.168.50.139''