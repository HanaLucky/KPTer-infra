# kpter-dev-infra
vagrant upする前に以下のプラグインをインストールする。
```
$ vagrant plugin install vagrant-hostsupdater
```

そうすると、http://local.kpter.net:3000やhttp://en.local.kpter.net:3000でアクセスできるのでローカライズの検証をすることができる。
vagrant upした時に以下の内容がローカルの/etc/hostsに追加されるので、ローカルでhostsを切り替えている場合はご注意を
```
192.168.33.60  localhost  # VAGRANT: 7fa82dad143c29e0f809e760e35da7af (develop) / 4a1fab20-41fd-458d-a3d3-a8df1f409b2f
192.168.33.60  local.kpter.net  # VAGRANT: 7fa82dad143c29e0f809e760e35da7af (develop) / 4a1fab20-41fd-458d-a3d3-a8df1f409b2f
192.168.33.60  en.local.kpter.net  # VAGRANT: 7fa82dad143c29e0f809e760e35da7af (develop) / 4a1fab20-41fd-458d-a3d3-a8df1f409b2f
```
