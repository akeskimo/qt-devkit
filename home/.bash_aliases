# general
alias nano="nano -c" # show line numbers by default when opening nano
alias qtvpn="sudo openconnect https://vpn.qt.io/qtvpn"

# devkit
alias vm_clone=call_clone_repos  # @+
alias vm_clean=QT_DEVKIT_PATH/tools/clean.sh
alias vm_setup=QT_DEVKIT_PATH/tools/setup.sh
alias vm_backup=call_backup  # @+
alias sync2vm=QT_DEVKIT_PATH/sync2vm/sync2vm

# ci
alias pst=print_state # @1
alias runwww="rm -rf www/ && make www_content && ./run_ci -r --skip-make"

function call_backup() {
 QT_DEVKIT_PATH/tools/backup.sh $@
}

function call_clone_repos {
 QT_DEVKIT_PATH/tools/clone-repos.sh $@
}

function print_state() {
 if [ ! -f "$1" ]; then
  echo File does not exist: $1
  return
 fi
 $HOME/tqtc-coin-ci/src/thrift_parser.py e $1
}
