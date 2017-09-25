# general
alias nano="nano -c" # show line numbers by default when opening nano

# devkit
alias vm_clone_repos="~/qt-devkit/tools/clone-repos.sh"
alias vm_clean="~/qt-devkit/tools/clean.sh"
alias vm_setup="~/qt-devkit/tools/setup.sh"
alias vm_backup="~/qt-devkit/tools/backup.sh"
alias sync2vm="~/qt-devkit/sync2vm/sync2vm"

# coin
function print_state_py() {
 # helper for tqtc-coin-ci/src/print_state.py
 if [ ! -z "$1" ]; then
  filepath=$1
  if [ ! "$filepath" = *"./"* ] && [ ! "$filepath" = "/"* ]; then
   filepath=./$filepath
  fi
  $QTCI_SRC/src/print_state.py e $filepath
 else
  for f in $(ls *.thrift_bin); do
   echo $f
   $QTCI_SRC/src/print_state.py e $f
  done
 fi
}
alias print_state=print_state_py # $1 ~ {filename}.thrift_bin
