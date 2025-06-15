
- [ ] **Better error handling**
  - More descriptive error messages
  - Handle common failure cases gracefully

- [ ] **Enhanced status command** 
  - Check which sync files are in/out of sync with remote
  - Use file hashing to detect differences
  - Show more detailed sync state information

- [ ] **Remote git reset functionality**
  - Command to force remote repo back to most recent commit
  - Avoid conflicts when pulling updates to remote
  - `podsync git-reset` or similar

- [ ] **Glob pattern support**
  - `podsync add "*.py"`
  - `podsync add "src/**/*.js"`
  - Pattern expansion and matching

- [ ] **Performance improvements**
  - Under the hood optimizations
  - Faster file transfers
  - Better handling of large files

- [ ] **Bidirectional sync (pull option)**
  - Download files from remote to local
  - `podsync pull` command
  - Figure out implementation approach

- [ ] **Improved config system** 
  - Consider hidden directory approach like `.git/`
  - Better organization of config data
  - Only if current approach becomes limiting

- [ ] **Better installation method**
  - Use `/usr/local/bin` instead of `~/bin` (more standard)
  - Consider Homebrew formula for distribution
  - Option to add repo directory directly to PATH

- [ ] **Move pod ID to environment variable**
  - Pod IDs are ephemeral (new session = new pod)
  - Use `RUNPOD_POD_ID` or `SYNC_POD_ID` env var instead of config file
  - Remove `set-pod` command or make it set session env var
  - Keep persistent config for files, paths, SSH key only
