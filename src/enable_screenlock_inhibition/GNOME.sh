trap stop_inhibiting EXIT

inhibitcmd="gnome-session-inhibit --inhibit idle --inhibit-only sleep infinity"
$inhibitcmd >/dev/null 2>&1 &

INHIBIT_PID=$!

stop_inhibiting() {
    /bin/kill "$INHIBIT_PID"
}
