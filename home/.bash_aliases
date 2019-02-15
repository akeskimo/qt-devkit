# general
alias nano="nano -c" # show line numbers by default when opening nano

# gerrit
alias gerrit_ssh_interactive='prepend_to_each_command ssh codereview.qt-project.org -p 29418 gerrit'

# devkit
alias vm_clone=call_clone_repos  # @+
alias vm_clean=QT_DEVKIT_PATH/tools/clean.sh
alias vm_setup=QT_DEVKIT_PATH/tools/setup.sh
alias vm_backup=call_backup  # @+
alias sync2vm=QT_DEVKIT_PATH/sync2vm/sync2vm

# qt vpn
alias qtvpn='screen -S qtvpn -m sudo openconnect vpn.qt.io/qtvpn'

function call_backup() {
 QT_DEVKIT_PATH/tools/backup.sh $@
}

function call_clone_repos {
 QT_DEVKIT_PATH/tools/clone-repos.sh $@
}

function prepend_for_each_command() {
 # Helper to prepend for each command and execute it.
 # Can be useful to send ssh commands to clients that have
 # interactive ssh disabled (such as gerrit).
 while read line; do $@ $line; done
}
