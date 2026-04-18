# Alias & Config Recommendations

## Changes Made

✅ **Consolidated Aliases**
- Created `dotfiles/bash/.bash_aliases` — sourced by `.bashrc`
- Created `dotfiles/fish/aliases.fish` — sourced by `config.fish`
- Fixed overlap: `dex` vs `dexec` (now standardized to `dex`)
- Added 15+ new aliases for safety and productivity

✅ **Updated `.gitignore`**
- Added sensitive patterns (`.ssh/config.local`, `.bash_aliases.local`, etc.)
- OS junk files (`.DS_Store`, `Thumbs.db`)
- Editor configs, backup files, temp files, logs

✅ **Setup Script Updated**
- Now symlinks `.bash_aliases` and `aliases.fish`
- Full fish integration (config + aliases)

---

## Recommendations & Future Improvements

### 1. 🔧 **Add Machine-Specific Configs** (⭐ HIGH PRIORITY)
Create overrides for per-machine customization:

**Bash:** Create `~/.bashrc.local` (ignored) for:
```bash
# Example ~/.bashrc.local (not in repo, machine-specific)
# Add to .bashrc: [ -f ~/.bashrc.local ] && source ~/.bashrc.local

export PROJECT_ENV="production"
export LOCAL_IP="192.168.1.100"
```

**Fish:** Create `~/.config/fish/local.fish` (ignored) for:
```fish
# Example: ~/.config/fish/local.fish
set -x PROJECT_ENV "production"
```

**Git:** Create `~/.gitconfig.local` (ignored) for:
```ini
[user]
    name = Charles
    email = charles@specific-machine.local
```

### 2. 📝 **Add SSH Config** (⭐ HIGH PRIORITY for 3-5 machines)
Create `dotfiles/ssh/config` for your homelab setup:

```ini
Host victus-server
    HostName 192.168.1.100
    User charles
    Port 22
    IdentityFile ~/.ssh/homelab_key
    ServerAliveInterval 60

Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/github_key
```

**Update setup.sh:**
```bash
if [ -f "$DOTFILES_DIR/ssh/config" ]; then
    install -m 600 "$DOTFILES_DIR/ssh/config" "$HOME/.ssh/config"
fi
```

### 3. 🚀 **Add Functions (not just aliases)**
Aliases have limits. Add real functions to `dotfiles/bash/functions.sh`:

```bash
# Kill process on port
kport() {
    sudo lsof -i :$1 | awk 'NR==2 {print $2}' | xargs sudo kill -9
}

# Docker cleanup
dclean() {
    docker system prune -f && docker image prune -f
}

# Git branch cleanup
gcclean() {
    git branch -vv | grep 'gone' | awk '{print $1}' | xargs git branch -D
}

# SSH into homelab
ssh-victus() {
    ssh charles@victus-server
}
```

### 4. 🎯 **Consistency Improvements**
- Current: `.bash_aliases` has comment headers like `# ===== Git =====`
- Recommendation: Keep this in `aliases.fish` too (makes scanning easier)
- Status: ✅ Already done

### 5. 💾 **Version Control for .bash_aliases**
Your `.bashrc` sources `~/.bash_aliases`, but now we want the repo version. Two approaches:

**Option A (Current):** Symlink (you have this)
```bash
ln -sf /path/to/dotfiles/bash/.bash_aliases ~/.bash_aliases
```

**Option B (Alternative):** Add to `.bashrc`:
```bash
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
elif [ -f $REPO_DIR/dotfiles/bash/.bash_aliases ]; then
    . $REPO_DIR/dotfiles/bash/.bash_aliases
fi
```

### 6. 🐠 **Fish Functions** (Advanced)
Consider adding `dotfiles/fish/functions/` directory:
```
dotfiles/
├── fish/
│   ├── config.fish
│   ├── aliases.fish
│   └── functions/
│       ├── kport.fish
│       ├── dclean.fish
│       └── ssh-victus.fish
```

Fish functions are more powerful than aliases for complex logic.

---

## New Aliases Added (Recommendations)

| Alias | Command | Use Case |
|-------|---------|----------|
| `..`, `...`, `....` | cd navigation | Faster directory traversal |
| `dexe` | `docker exec -it` | Interactive docker exec |
| `dpsq` | `docker ps -q` | Get only container IDs (piping) |
| `dcompup` | `docker compose up -d` | Replace long docker compose command |
| `dcompdown` | `docker compose down` | Quick compose shutdown |
| `df` | `df -h` | Human-readable disk space |
| `du` | `du -h` | Human-readable disk usage |
| `ports` | `netstat -tulanp` | See listening ports |
| `listening` | `lsof -i -P -n \| grep LISTEN` | List listening services |
| `ga` | `git add` | Faster git staging |
| `gp` | `git push` | Quick push |
| `gl` | `git log --oneline -10` | Last 10 commits |
| `mkdir` | `mkdir -p` | No error if exists |
| `cp` | `cp -i` | Prompt before overwrite |
| `mv` | `mv -i` | Prompt before overwrite |
| `rm` | `rm -i` | Prompt before delete |

---

## Next Steps to Hit 9.5/10

1. ✅ Add `.bash_aliases` file → **DONE**
2. ✅ Add `aliases.fish` file → **DONE**
3. ✅ Update `.gitignore` → **DONE**
4. ⏳ Add SSH config (`dotfiles/ssh/config`)
5. ⏳ Add machine-specific override templates to DOTFILES_GUIDE
6. ⏳ Add bash functions file
7. ⏳ Add fish functions directory (optional, advanced)
8. ⏳ Add README.md with quick start

---

## Quick Test

Try the setup script:
```bash
./setup.sh
source ~/.bashrc
# Test an alias
ll
# Or for fish: exec fish
```

All aliases should now be available on both shells! 🎉
