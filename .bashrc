export VISUAL=nvim
export PAGER=less
export HISTCONTROL=ignoreboth
export QT_QPA_PLATFORMTHEME="qt5ct"
export _JAVA_AWT_WM_NONREPARENTING=1
export PATH="/opt/openchrom_cromatografia:$PATH"
export PATH="${PATH}:/usr/lib/rstudio"
export LESS='-R --use-color -Dd+r$Du+b'
source /etc/profile

alias ls="ls --color=auto"
alias ll="ls -la"
alias vi="nvim"
alias gs="git status"
alias ga="git add -A"
alias gc="git commit -m"
alias gp="git push"
alias cl="clear"
alias nf="neofetch"
alias nb="newsboat"
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias ip='ip -color=auto'
