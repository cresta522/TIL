### beep音を消す方法 (ubuntu wsl2)

#### 設定ファイル
`~/.inputrc`

#### ファイル自作するパターン

`vim ~/.inputrc`

`set bell-style none`

を追記

#### vimが面倒なら

`echo "set bell-style none" >> ~/.inputrc`

#### WSLからDocker!

ユーザがWSLではWindowsユーザでも、dockerはデフォでrootになってしまう。

##### 参考
https://wonwon-eater.com/docker-non-root/

dockerで指定可能。案件だと使えないかもだから個人開発では注意。