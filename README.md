# PodSync

A simple CLI tool for syncing local files to RunPod instances via SSH/SCP.

## Features

- **Subcommand-based interface** - Easy to use commands for different operations
- **Configuration file** - Uses `.podsync` file (like `.gitconfig`) for persistent settings
- **Automatic SSH discovery** - Extracts connection details from `runpodctl get pod`
- **Flexible remote paths** - Configurable remote base path (default: `/workspace`)
- **File management** - Add/remove files from sync list
- **Dry run support** - Preview what will be synced before doing it

## Installation

1. Clone or download this repository
2. Run the installer:
   ```bash
   ./install.sh
   ```

The installer copies `podsync` to `~/bin/` and makes it executable. Make sure `~/bin` is in your PATH.

## Quick Start

```bash
# Navigate to your project directory
cd /path/to/your/project

# Set your target pod ID
podsync set-pod k4kb5h7yt7n15n

# Set remote base path (optional, defaults to /workspace)
podsync set-remote-path /workspace/my-project

# Add files to sync
podsync add script.py
podsync add config.json
podsync add data/input.txt

# Check status
podsync status

# Sync files
podsync sync

# Or preview what would be synced
podsync sync --dry-run
```

## Commands

### Configuration Commands

- `podsync set-pod <pod-id>` - Set the target pod ID
- `podsync set-remote-path <path>` - Set the remote base path (default: `/workspace`)
- `podsync status` - Show current configuration and file list

### File Management Commands

- `podsync add <file>` - Add a file to the sync list
- `podsync remove <file>` - Remove a file from the sync list

### Sync Commands

- `podsync sync` - Sync all files in the list to the pod
- `podsync sync --dry-run` - Preview what would be synced
- `podsync sync --remote-path <path>` - Override remote base path for this sync

### Help

- `podsync help` - Show usage information

## Configuration File

PodSync uses a `.podsync` file in your project directory to store configuration:

```bash
# Pod sync configuration
SYNC_POD_ID="k4kb5h7yt7n15n"
SYNC_FILES="script.py:config.json:data/input.txt"
SYNC_SSH_KEY="~/.ssh/id_ed25519"
SYNC_REMOTE_PATH="/workspace/my-project"
```

## How It Works

1. **Pod Discovery**: Uses `runpodctl get pod <id> --allfields` to get SSH connection details
2. **SSH Connection**: Extracts host and port from RunPod's SSH forwarding info
3. **File Sync**: Uses `scp` to copy files, creating remote directories as needed
4. **Path Mapping**: Files are copied to `<remote-base-path>/<local-file-path>`

## Examples

### Basic Workflow
```bash
# Setup
podsync set-pod abc123
podsync add train.py
podsync add data/dataset.csv

# Sync files
podsync sync
```

### Custom Remote Path
```bash
# Set permanent remote path
podsync set-remote-path /workspace/experiments

# Or override for one sync
podsync sync --remote-path /tmp/test
```

### Managing Files
```bash
# Add multiple files
podsync add src/model.py
podsync add configs/training.yaml

# Check what's configured
podsync status

# Remove a file
podsync remove old_script.py
```

## Requirements

- `runpodctl` - RunPod CLI tool (for pod discovery)
- `ssh` and `scp` - Standard SSH tools
- SSH key configured for RunPod access (default: `~/.ssh/id_ed25519`)

## Troubleshooting

### "No pod ID specified"
Run `podsync set-pod <your-pod-id>` first.

### "Failed to get pod details"
- Check that the pod ID is correct
- Ensure `runpodctl` is installed and configured
- Verify the pod is running

### "Could not extract SSH connection details"
- Pod might not be running
- SSH might not be enabled on the pod
- Try `runpodctl get pod <id> --allfields` manually to check

### "~/bin is not in your PATH"
Add this to your shell profile (`~/.bashrc`, `~/.zshrc`, etc.):
```bash
export PATH="$HOME/bin:$PATH"
```

## License

MIT License - feel free to use and modify as needed.