cleanup() {
    /bin/kill "$INHIBIT_PID"
}

trap cleanup EXIT

inhibitcmd="gnome-session-inhibit --inhibit sleep --inhibit-only sleep infinity"
$inhibitcmd >/dev/null 2>&1 &

INHIBIT_PID=$!