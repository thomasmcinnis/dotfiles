# Git Profile Management

This directory contains your git profile configuration files.

Create two files here (they are git-ignored by default):
- `.gitconfig.work` - Your work git profile
- `.gitconfig.personal` - Your personal git profile

Example content for each file:

```
[user]
    name = Your Name
    email = your.email@company.com
    signingkey = YOUR_GPG_KEY_ID  # Optional

[github]
    user = your-github-username
```

The currently selected profile is symlinked to `.gitconfig.current` and is included in the main git config.