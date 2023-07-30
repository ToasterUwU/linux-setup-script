stop_inhibiting() {
    /bin/kill "$INHIBIT_PID"
}

trap stop_inhibiting EXIT

inhibitcmd="kde-inhibit --screenSaver --power sleep infinity"
$inhibitcmd >/dev/null 2>&1 &

INHIBIT_PID=$!
