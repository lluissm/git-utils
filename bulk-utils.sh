# Clones all git repos of a given user or organization using GitHub CLI (https://cli.github.com)
# $1 user/org
# $2 access_token (optional)
clone_repos() {

  if [ -z "$1" ]; then
      echo "Please provide the user or organization for which to download the repos as a first parameter"
      return
  fi

  local user_or_org="${1}"
  local include_archived=1

  # Login to GitHub
  if [ -z "$2" ]; then
    # Log in and configure ssh for git operations
    gh auth login --hostname github.com -p ssh

    # Ask whether to include archived repos
    while true; do
        echo "Do you want to include archived repos? (Y/n): "
        read -r yn
        case $yn in
            [Yy]* ) break;;
            [Nn]* ) include_archived=0; break;;
            * ) printf "Please answer yes or no\n";;
        esac
    done
  else 
    # Log in using provided token
    gh auth login --hostname github.com --with-token "${2}"
  fi

  # Create a temporary file with all the repositories for that user/org
  gh repo list "$user_or_org" $( (( incl_archived==0 )) && printf %s '--no-archived') | awk NF=1 > repos.txt

  # Clone all the repositories
  while read p; do
    echo "Attempting to clone $p"
    gh repo clone $p
  done <repos.txt

  rm repos.txt
}

# Pulls all branches from remote for all the git repositories in the current folder
update_repos() {
  find . -mindepth 1 -maxdepth 1 -type d -exec sh -c 'echo "Updating ${}" && (cd {} && git pull --all)' ';'
}