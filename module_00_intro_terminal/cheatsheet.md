# Terminal Cheatsheet

## Navigation
| Command | Description | Example |
|---|---|---|
| `pwd` | Print Working Directory | `pwd` |
| `ls` | List files and directories | `ls -la` (list all including hidden) |
| `cd` | Change Directory | `cd my_folder` |
| `cd ..` | Go up one directory | `cd ..` |
| `cd ~` | Go to home directory | `cd ~` |

## File Operations
| Command | Description | Example |
|---|---|---|
| `mkdir` | Make Directory | `mkdir new_folder` |
| `touch` | Create empty file | `touch empty.txt` |
| `cp` | Copy file/directory | `cp file.txt copy.txt` or `cp -r folder copy_folder` |
| `mv` | Move or Rename | `mv file.txt new_name.txt` or `mv file.txt folder/` |
| `rm` | Remove file | `rm file.txt` |
| `rm -r` | Remove directory | `rm -rf folder_name` (**BE CAREFUL**) |

## Viewing Content
| Command | Description | Example |
|---|---|---|
| `cat` | Display file content | `cat file.txt` |
| `less` | View large file (scrollable) | `less large_file.log` (press `q` to exit) |
| `head` | View first 10 lines | `head -n 5 file.txt` |
| `tail` | View last 10 lines | `tail -f log.txt` (follow updates) |
| `grep` | Search text in file | `grep "Hello" file.txt` |

## System
| Command | Description |
|---|---|
| `clear` | Clear terminal screen |
| `man` | Manual/Help for command (e.g., `man ls`) |
| `History` | Show command history |
