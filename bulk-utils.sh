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
    # Log in and configure ssh for git operations if no auth token is provided
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
    # Log in using the provided token
    gh auth login --hostname github.com --with-token "${2}"
  fi

  # Create a tmp file with all the repositories for that user/org
  gh repo list "$user_or_org" --limit 1000 $( (( include_archived==0 )) && printf %s '--no-archived') | awk NF=1 > .repos_to_clone.txt

  # Create a tmp file with all the repositories that already exist in the folder
  find . -mindepth 1 -maxdepth 1 -type d > .folders.txt
  touch .existing_repos.txt
  while read e; do
    echo -e ${e/".\/"/"${user_or_org}/"} >> .existing_repos.txt
  done <.folders.txt

  # Clone all the repositories that do not exist yet
  while read p; do
    if grep -Fxq "$p" .existing_repos.txt; then
        echo "$p already exists"
    else
      gh repo clone $p
    fi
  done <.repos_to_clone.txt

  rm .repos_to_clone.txt
  rm .folders.txt
  rm .existing_repos.txt
}

# Pulls all branches from remote for all the git repositories in the current folder
update_repos() {
  find . -mindepth 1 -maxdepth 1 -type d -exec sh -c 'echo "Updating ${}" && (cd {} && git pull --all)' ';'
}