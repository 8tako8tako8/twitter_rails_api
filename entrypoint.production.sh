#!/bin/bash
set -e

# 既存の server.pid を削除
rm -f /myapp/tmp/pids/server.pid

# db:migrate
bundle exec rails db:migrate

# メインプロセス(DockerfileのCMDで指定されたコマンド)を実行する
exec "$@"
