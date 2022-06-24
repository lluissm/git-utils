# git-utils

Bulk clone git repositories from your GitHub account/organization (using GitHub CLI) by typing `clone_repos`.

Update all the git repositories in a folder by typing `update_repos`.

![Header](example.gif)

## Setup

1. Install [GitHub CLI](https://cli.github.com) (necessary for `clone_repos`)
2. Add the functions to your shell configuration file (e.g., `~/.zshrc` for zsh shell) by either:
    1. Copying the desired functions from `bulk-utils.sh` directly
    2. Importing it by adding: `source /path/to/git-utils/bulk-utils.sh`
3. Reload the shell settings by typing `source ~/.zshrc` or close and reopen the terminal

## Usage

To clone all repositories for a given user, navigate to the desired folder and type:

`clone_repos`

To update all git repositories in a folder, navigate to the desired folder and type:

`update_repos`
