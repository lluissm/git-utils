# Clones all git repos of a given user or organization using GitHub CLI (https://cli.github.com)
clone_repos() {
  # Log in and configure ssh for git operations
  gh auth login -p ssh

  # Get user or organization for which we will fetch all repos
  echo 'For which user or organization do you wish to clone all repos: '
  read -r user_or_org

  # Create a tmp file with all the repositories for that user/org
  gh repo list "$user_or_org" | awk NF=1 > repos

  # Clone all the repositories
  while read p; do
    echo "Attempting to clone $p"
    gh repo clone $p
  done <repos

  # Delete the tmp file
  rm repos
}

# Pulls all branches from remote for all the git repositories in the current folder
update_repos() {
  find . -mindepth 1 -maxdepth 1 -type d -exec sh -c 'echo "Updating ${}" && (cd {} && git pull --all)' ';'
}
