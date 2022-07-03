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

### Clone all repositories for a giver user/org

Navigate to the desired folder and type:

`clone_repos <user> <access_token>`

When an access_token is provided, it will automatically download all the repos in a fully unattended mode.

When an access_token is NOT provided, it will prompt the user to authenticate to GitHub and will assume that SSH is the preferred method for cloning the repos.

### Udate all git repositories in a folder

Navigate to the desired folder and type:

`update_repos`
