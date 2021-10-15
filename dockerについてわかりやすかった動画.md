dockerについてわかりやすかった動画
https://www.youtube.com/watch?v=VIzLh4BgKck

## docker インストール元
https://hub.docker.com/editions/community/docker-ce-desktop-windows/

## Apache起動メモ
https://weblabo.oscasierra.net/apache-installing-apache24-yum-centos7-1/

## 使ったコマンド
### dockerHubからダウンロード 
`docker pull mysql`

`docker pull httpd`

`docker pull centos`

### ダウンロードしたイメージの一覧
`docker images`

### 現在動いているインスタンスの一覧
`docker ps -a `

### イメージを動かして、bashでる￥
`docker run -it centos bash`

option: `-it {arg1} {arg2}` オプション:{arg1}イメージに対して{arg2}コマンドを実行する

### 抜け方
exit だと コンテナが停止してしまうため、
Ctrl + P + Q で抜ける

一度起動して抜けたコンテナに入るには

`docker attach {CONTAINER ID}`

## コンテナ停止
`docker stop {CONTAINER ID}`
## コンテナ削除
`docker rm {CONTAINER ID}`
## コンテナ強制削除
`docker rm -f {CONTAINER ID}`
## イメージ削除
`docker rmi {IMAGE ID}`

## マウント
`docker run -it -v /D/projects/stufy6:/var/www/docker centos bash`

option: `-v {From}:{To}`

## ポートマウント
`docker run -it -p 8080:80 centos bash`

option: `-p {From}:{To}`

localhost:8080 で dockerの80にアクセスできる

## イメージを自分で作る
コンテナを作成し、自分のオリジナルイメージを作る場合
`docker commit {CONTAINER ID} {IMAGE NAME}`
で作られる。

## centos7 で dockerfile
CentOS7では `systemctl` が最初から使えない。

また **--privileged**  をオプションで付けないとフリーズする。

参考: https://qiita.com/mikene_koko/items/4c71c969f55e3fe24190

`docker run --privileged -p8080:80 -it {CONTAINER ID} /sbin/init` で行える。

`docker run --privileged -p8080:80 -it {CONTAINER ID} bash `は無理。

**/sbin/init** で 開始した後、**Ctrl + P + Q** で抜けて、

`docker exec -it {CONTAINER ID} /bin/bash`

で実行できます。

## php7 の準備
https://registry.hub.docker.com/r/rdeleo/centos7-php7.4-cli/dockerfile