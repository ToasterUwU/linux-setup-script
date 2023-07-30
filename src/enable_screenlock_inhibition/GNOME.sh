stop_inhibiting() {
    /bin/kill "$INHIBIT_PID"
}

trap stop_inhibiting EXIT

inhibitcmd="gnome-session-inhibit --inhibit sleep --inhibit-only sleep infinity"
$inhibitcmd >/dev/null 2>&1 &

INHIBIT_PID=$!
