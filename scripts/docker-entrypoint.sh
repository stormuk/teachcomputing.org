#!/bin/sh
set -e

RAILS_EXECUTABLE="bin/rails"
PORT=3000
IP=0.0.0.0
DEBUG_PORT=1234
DISPATCHER_PORT=26162

PID="tmp/pids/server.pid"
if [ -f $PID ]; then
  rm $PID
fi

echo "- Configuring databases:"
bundle exec rake db:prepare

echo "- Starting rails:"
# Will start normally, allowing later debug sessions
rdebug-ide --skip_wait_for_start --host $IP --port $DEBUG_PORT --dispatcher-port $DISPATCHER_PORT -- $RAILS_EXECUTABLE s -p $PORT -b $IP
