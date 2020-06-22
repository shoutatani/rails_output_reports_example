# Rails 6 template

## 概要

Rails 6のアプリケーションを、MySQL 8系と共に動かす開発環境のテンプレートです。

## 使い方

ただdocker-compose で起動するだけです。

```
docker-compose up
```

## Rails6 セットアップ時コマンド

/Rails ディレクトリのRails6アプリケーションを構築した際のコマンドです。
ruby 2.7.1系をベースに作成しました。

1. rails-output-reports271 という名前のコンテナを、ruby:2.7.1-busterのイメージから作成しました。なお、ホスト側のボリュームをマウントさせることで、ホスト側から作業ディレクトリが見えるようにしています。

```
docker run --name rails-output-reports271 -d -v ~/src/github.com/shoutatani/rails_output_reports_example/Rails:/RailsApp/ ruby:2.7.1-buster tail -f /dev/null
```

2. Rails6 環境の構築

```log
$ cd RailsApp/
$ bundle init # => rails gemを有効化
$ bundle install --jobs=4
$ bundle exec rails new . -B -d mysql --skip-turbolinks --skip-javascript # => railsの依存gemのインストールは自動生成後のGemfileの整理後に行うため、--skip-bundle オプションを指定。なお、turbolinksは一旦消しているが、フロント周りの構築が終わった後に必要であれば入れる。webpacker系も使わず自前で構築するため、--skip-turbolinksを指定。
$ bundle install
```
