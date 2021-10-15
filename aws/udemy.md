# Udemyで学んだことまとめ
- VPCのSIDRは10.0.0.0/16が定番
- SubnetはPrivateとPublicに分けてDMZを作るのがセキュリティ面で安定
    - SIDRは10.0.*.0/24

- VPCにあてるF/WがNetwork ACLs
    - 許可と拒否を決める
- 各サブネットに当てるF/Wがセキュリティグループ
- ルートテーブルはVPCにもサブネットにもあてる。

- PrivateからはPublicに配置したNatGWを経由してネットに繋ぐ。
- NW-ACLは Inbound/Outboundに分けて設定する
    - プロトコル単位での許可拒否、IPでの許可拒否
    - ベストプラクティス
        - In: 100 ssh, 200 http, 300 https
        - Out: 100 http, 200 https, 300 1024-65535

- IAMの権限はユーザとグループとリソースに対して設定可能

- sshでprivateのec2に入るにはpublicのsshに鍵をコピーして`ssh ec2-user@x.x.x.x -i key.pem`

- privateにDBをおいてる場合 **private**のSGのInboundに