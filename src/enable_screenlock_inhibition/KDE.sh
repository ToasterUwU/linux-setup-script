cleanup() {
    /bin/kill "$INHIBIT_PID"
}

trap cleanup EXIT

inhibitcmd="kde-inhibit --screenSaver --power sleep infinity"
$inhibitcmd >/dev/null 2>&1 &

INHIBIT_PID=$!