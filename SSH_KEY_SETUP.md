# SSH Key Setup for GitHub

## ✅ Your Current Status
**You already have SSH keys configured and authenticated with GitHub!**
- Username: `mkshepherd1`
- Key type: ED25519 (most secure)
- Status: Already working!

## Your Public Key
```
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOIdzkhViasffjSAITz2h8DNiEZT72SS7zT1oLh+u2ey opc@instance-20250708-0832
```

## To Add This Key to GitHub (if needed)

### Step 1: Copy Your Public Key
```bash
cat ~/.ssh/id_ed25519.pub
```
Copy the entire output.

### Step 2: Add to GitHub
1. Go to: https://github.com/settings/keys
2. Click **New SSH key**
3. Title: `Oracle Cloud Instance` (or any name you prefer)
4. Key type: `Authentication Key`
5. Key: Paste your public key
6. Click **Add SSH key**

### Step 3: Test Connection
```bash
ssh -T git@github.com
```
You should see:
```
Hi mkshepherd1! You've successfully authenticated, but GitHub does not provide shell access.
```

## If You Need to Generate New SSH Keys

**Only do this if your current keys aren't working!**

### 1. Generate New Key
```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```
- Press Enter to accept default location
- Enter a passphrase (optional)

### 2. Start SSH Agent
```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

### 3. Copy Public Key
```bash
cat ~/.ssh/id_ed25519.pub
```

### 4. Add to GitHub
Follow the steps above to add the key to GitHub.

## Common SSH Issues & Solutions

### Permission Denied
```bash
# Check if SSH agent is running
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# Verify correct permissions
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_ed25519
chmod 644 ~/.ssh/id_ed25519.pub
```

### Multiple GitHub Accounts
Create `~/.ssh/config`:
```
Host github.com
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519

Host github-work
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519_work
```

### Test Your Connection
```bash
ssh -vT git@github.com  # Verbose output for debugging
```

## Your Current Git Remote
Your repository is configured to use SSH:
```
git@github.com:mkshepherd1/prime-docs.git
```

## Quick Commands
```bash
# Check current remotes
git remote -v

# Change from HTTPS to SSH
git remote set-url origin git@github.com:mkshepherd1/prime-docs.git

# Push to GitHub
git push -u origin main
```

---

**Remember:** Your SSH is already working! You just need to create the repository on GitHub first, then you can push.