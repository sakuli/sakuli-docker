#!/bin/bash
### every exit != 0 fails the script
set -e

## print out help
help (){
echo "
USAGE:
docker run -it -p 6901:6901 -p 5901:5901 consol/<image>:<tag> <option>

IMAGES:
taconsol/sakuli

OPTIONS:
-w, --wait      (default) keeps the UI and the vncserver up until SIGINT or SIGTERM will received
-s, --skip      skip the vnc startup and just execute the assigned command.
                example: docker run taconsol/sakuli --skip bash
-d, --debug     enables more detailed startup output
                e.g. 'docker run taconsol/sakuli --debug bash'
-h, --help      print out this help
"
}
if [[ $1 =~ -h|--help ]]; then
    help
    exit 0
fi

# should also source $STARTUPDIR/generate_container_user
source $HOME/.bashrc

node $STARTUPDIR/env/startup.js

# add `--skip` to startup args, to skip the VNC startup procedure
if [[ $1 =~ -s|--skip ]]; then
    echo -e "\n\n------------------ SKIP VNC STARTUP -----------------"
    echo -e "\n\n------------------ EXECUTE COMMAND ------------------"
    echo "Executing command: '${@:2}'"
    exec "${@:2}"
fi
if [[ $1 =~ -d|--debug ]]; then
    echo -e "\n\n------------------ DEBUG VNC STARTUP -----------------"
    export DEBUG=true
fi

## correct forwarding of shutdown signal
cleanup () {
    kill -s SIGTERM $!
    exit 0
}
trap cleanup SIGINT SIGTERM

## write correct window size to chrome properties
$STARTUPDIR/chrome-init.sh

## resolve_vnc_connection
VNC_IP=$(hostname -i)

## change vnc password
echo -e "\n------------------ change VNC password  ------------------"
# first entry is control, second is view (if only one is valid for both)
mkdir -p "$HOME/.vnc"
PASSWD_PATH="$HOME/.vnc/passwd"

if [[ -f $PASSWD_PATH ]]; then
    echo -e "\n---------  purging existing VNC password settings  ---------"
    rm -f $PASSWD_PATH
fi

if [[ $VNC_VIEW_ONLY == "true" ]]; then
    echo "start VNC server in VIEW ONLY mode!"
    #create random pw to prevent access
    echo $(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 20) | vncpasswd -f > $PASSWD_PATH
fi
echo "$VNC_PW" | vncpasswd -f >> $PASSWD_PATH
chmod 600 $PASSWD_PATH


## start vncserver and noVNC webclient
echo -e "\n------------------ start noVNC  ----------------------------"
if [[ $DEBUG == true ]]; then echo "$NO_VNC_HOME/utils/launch.sh --vnc localhost:$VNC_PORT --listen $NO_VNC_PORT"; fi
$NO_VNC_HOME/utils/launch.sh --vnc localhost:$VNC_PORT --listen $NO_VNC_PORT &> $STARTUPDIR/no_vnc_startup.log &
PID_SUB=$!

echo -e "\n------------------ start VNC server ------------------------"
echo "remove old vnc locks to be a reattachable container"
vncserver -kill $DISPLAY &> $STARTUPDIR/vnc_startup.log \
    || rm -rfv /tmp/.X*-lock /tmp/.X11-unix &> $STARTUPDIR/vnc_startup.log \
    || echo "no locks present"

echo -e "start vncserver with param: VNC_COL_DEPTH=$VNC_COL_DEPTH, VNC_RESOLUTION=$VNC_RESOLUTION\n..."
if [[ $DEBUG == true ]]; then echo "vncserver $DISPLAY -depth $VNC_COL_DEPTH -geometry $VNC_RESOLUTION"; fi
vncserver $DISPLAY -depth $VNC_COL_DEPTH -geometry $VNC_RESOLUTION &> $STARTUPDIR/no_vnc_startup.log
echo -e "start window manager\n..."
$HOME/wm_startup.sh &> $STARTUPDIR/wm_startup.log

## log connect options
echo -e "\n\n------------------ VNC environment started ------------------"
echo -e "\nVNCSERVER started on DISPLAY= $DISPLAY \n\t=> connect via VNC viewer with $VNC_IP:$VNC_PORT"
echo -e "\nnoVNC HTML client started:\n\t=> connect via http://$VNC_IP:$NO_VNC_PORT/?password=...\n"


if [[ $DEBUG == true ]]; then
    echo -e "\n------------------ $HOME/.vnc/*$DISPLAY.log ------------------"
    # if option `-t` or `--tail-log` block the execution and tail the VNC log
    TAIL_PARAMETERS=""
    if [[ $1 =~ -t|--tail-log ]]; then
      TAIL_PARAMETERS="-f"
    fi
    tail ${TAIL_PARAMETERS} $STARTUPDIR/*.log $HOME/.vnc/*$DISPLAY.log
fi

if [[ -n "$GIT_URL" ]]; then
    echo -e "\n\n------------------ CLONE GIT REPOSITORY ---------------------------"
    git clone $GIT_URL /headless/git-repository
fi

## Preparing execution environment
RSYNC_OPTIONS="-aO"
if [[ $DEBUG == true ]]; then
    RSYNC_OPTIONS="${RSYNC_OPTIONS}v"
else
    RSYNC_OPTIONS="${RSYNC_OPTIONS}q"
fi

[[ $DEBUG == true ]] && echo "Syncing test suite to execution environment."
if [ "${SAKULI_TEST_SUITE}" ]; then
  rsync ${RSYNC_OPTIONS} ${SAKULI_TEST_SUITE}/* ${SAKULI_EXECUTION_DIR} --exclude node_modules
else
  # Ensure nothing breaks if user mounts into ${HOME}/demo_testcase for any reason
  rsync ${RSYNC_OPTIONS} ${HOME}/demo_testcase/* ${SAKULI_EXECUTION_DIR} --exclude node_modules
fi
# Link global node_modules into ${SAKULI_EXECUTION_DIR}
[[ $DEBUG == true ]] && echo "Linking global node_modules to execution environment."
ln -s $(npm root -g | head -n 1) ${SAKULI_EXECUTION_DIR}/node_modules

set +e

if [ -z "$1" ] || [[ $1 =~ -w|--wait ]]; then
    wait $PID_SUB
else
    # unknown option ==> call command
    echo -e "\n\n------------------ EXECUTE COMMAND ------------------"
    echo "Executing command: '$@'"
    $@
fi

## Restore logs and screenshots into the actual mounted volume, if possible
[[ $DEBUG == true ]] && echo "Restoring testsuite to ${SAKULI_TEST_SUITE}."
RESTORE_COMMAND="rsync ${RSYNC_OPTIONS} ${SAKULI_EXECUTION_DIR}/* ${SAKULI_TEST_SUITE} --exclude node_modules"
if [[ $DEBUG == true ]]; then
    echo "${RESTORE_COMMAND}"
    ${RESTORE_COMMAND}
else
    ${RESTORE_COMMAND} 2>/dev/null
fi
[ $? -ne 0 ] && echo -e "ERROR: Could not restore logs and screenshots due to insufficient permissions."

set -e