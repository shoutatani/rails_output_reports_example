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

1. rails-dev271 という名前のコンテナを、ruby:2.7.1-busterのイメージから作成しました。なお、ホスト側のボリュームをマウントさせることで、ホスト側から作業ディレクトリが見えるようにしています。

```
docker run --name rails-dev271 -d -v ~/develop/ruby271/Rails:/src/ ruby:2.7.1-buster tail -f /dev/null
```

2. Rails6 環境の構築

```log
$ cd src/
$ bundle init # => rails gemを有効化
$ bundle install --path vendor/bundle --jobs=4
$ bundle exec rails new . -B -d mysql --skip-turbolinks --skip-webpack-install # => railsの依存gemのインストールは自動生成後のGemfileの整理後に行うため、--skip-bundle オプションを指定。なお、turbolinksは一旦消しているが、フロント周りの構築が終わった後に必要であれば入れる。webpacker系も使わず自前で構築するため、--skip-webpack-installを指定。なお、自動生成されたGemfileの中のwebpackerの無効化を、この行の後に行っている。
$ bundle install
```
