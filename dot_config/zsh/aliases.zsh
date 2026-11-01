# git
alias gs='git status -sb'
alias gp='git push'
alias gpf='git push --force-with-lease'
alias gpl='git pull'
alias gl='git log --oneline --graph --decorate -20'
alias gd='git diff'
alias gds='git diff --staged'
alias gb='git blame -w -C -C -C'
alias gbr='git branch'
alias gco='git checkout'
alias gcb='git switch -c'
alias ga='git add'
alias gap='git add -p'
alias gc='git commit -v'
alias gcan='git commit --amend --no-edit'
alias gst='git stash'
alias gstp='git stash pop'

# data
# csvhead [delimiter] < file.csv  - each header with its first value
csvhead() { mlr --icsv --oxtab --ifs "${1:-,}" head -n 1; }
