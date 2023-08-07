trap stop_inhibiting EXIT

inhibitcmd="kde-inhibit --screenSaver sleep infinity"
$inhibitcmd >/dev/null 2>&1 &

INHIBIT_PID=$!

stop_inhibiting() {
    /bin/kill "$INHIBIT_PID"
}
