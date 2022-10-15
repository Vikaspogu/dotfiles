# dotfiles

## Plugins

```bash
plugins=(
  git
  zsh-autosuggestions
  zsh-completions
  dotenv
  autojump
)
```

## Alias

```bash
alias vi="nvim"
alias vim="nvim"
alias k="kubectl"
alias kd="kubectl delete pod"
alias klog="kubectl logs -f"
alias kpod="kubectl get pods"
alias kpodall="kubectl get pods --all-namespaces"
alias brewup="brew update; brew upgrade --cask; brew upgrade; brew cleanup --prune=all; brew doctor"
alias docker="podman"
```
