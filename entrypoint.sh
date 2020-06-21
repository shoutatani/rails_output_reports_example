#!/bin/bash

cd ${RAILS_ROOT}

rm -rf tmp/pids/server.pid

echo "========== bundle install =========="
bundle install

echo "========== Start rails server =========="
bundle exec rails server -b 0.0.0.0 -p 80

echo "========== Done: `date` =========="
touch log/development.log
tail -f log/development.log