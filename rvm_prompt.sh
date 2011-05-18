#
# Sets up my BASH prompt with git and rvm statuses
#

# incorporate rvm into prompt
if [ -s "$HOME/.rvm/contrib/ps1_functions" ]; then
    source "$HOME/.rvm/contrib/ps1_functions"

    # add blank line before prompt with echo
    PROMPT_COMMAND="echo; ps1_update"
fi

