# 🔐 Fix GitHub Permissions for algocookbook/prime-docs

## The Issue
Your SSH key (authenticated as `mkshepherd1`) doesn't have write access to the `algocookbook` organization repository.

## Solution Options

### Option 1: Add mkshepherd1 as Collaborator
1. Go to: https://github.com/algocookbook/prime-docs/settings/access
2. Click **Add people**
3. Enter: `mkshepherd1`
4. Choose role: **Write** or **Admin**
5. Send invitation

### Option 2: Use HTTPS with Token (Quick Fix)
1. Generate a Personal Access Token:
   - Go to: https://github.com/settings/tokens/new
   - Name: `PRIME Docs Push`
   - Expiration: Your choice
   - Scopes: ✅ `repo` (full control)
   - Click **Generate token**
   - Copy the token!

2. Push with token:
```bash
# Remove SSH remote
git remote remove origin

# Add HTTPS remote
git remote add origin https://github.com/algocookbook/prime-docs.git

# Push with token as password
git push -u origin main
# Username: your-github-username
# Password: paste-your-token-here
```

### Option 3: Fork and Pull Request
1. Fork the repository to mkshepherd1:
   - Go to: https://github.com/algocookbook/prime-docs
   - Click **Fork** button
   - Creates: https://github.com/mkshepherd1/prime-docs

2. Push to your fork:
```bash
git remote set-url origin git@github.com:mkshepherd1/prime-docs.git
git push -u origin main
```

3. Create Pull Request:
   - Go to your fork
   - Click **Contribute** → **Open pull request**

### Option 4: Organization Member Access
If you own or admin the `algocookbook` organization:
1. Go to: https://github.com/orgs/algocookbook/people
2. Add `mkshepherd1` as member
3. Grant appropriate permissions

## Quick Command to Try

After fixing permissions, push with:
```bash
git push -u origin main
```

## Test Your Access
```bash
# Test SSH access to the repo
ssh -T git@github.com
# Should show: Hi mkshepherd1! You've successfully authenticated...

# Test repository access
git ls-remote git@github.com:algocookbook/prime-docs.git
```

---

**Note:** Your documentation is ready and committed locally. Once permissions are fixed, the push will work immediately!