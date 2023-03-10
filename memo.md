## ShellCheck
shell scriptを書くときは、VSCodeなどの拡張機能にShellCheckを入れておくとよい。

ありがちなエラーや危険な構文に警告を出してくれる。

### 標準入出力を追記したい
記号>を2つ使う>>

一つだけだと、ファイルが存在する場合上書きされる。
```
$ date > timestamp.txt
$ date >> timestamp.txt
```

### 標準エラーも扱う
記号>によってリダイレクトされるのは標準出力のみ

標準エラー出力も扱うには 2>&1をつける。
```
$ date >> timestamp.txt 2>&1
```
2は標準エラー出力のファイルディスクリプタ番号で、

1は標準出力のファイルディスクリプタ番号。

最後の2>&1で標準エラー出力を標準入力に統合している。

### コマンドを組み合わせる
```
cmd1を実行後、cmd2を実行
cmd1 ; cmd2
例
$ cd /home ; ls
/homeに移動後、ls

cmd1の実行に成功したら、cmd2を実行
cmd1 && cmd2
例
$ cd /home && ls
/homeに移動出来たら、ls

cmd1の実行に失敗したら、cmd2を実行
cmd1 || cmd2
例
$ cd ~/foo || mkdir ~/foo
~/fooに移動出来なかったら、~/fooディレクトリを作成
```

### [...]と[^...]による展開
```
1文字目がt,e,zのいずれか、2文字目がj,pのいずれかではじまる
$ ls /usr/bin/[tez][jp]*

AからVまでみたいな範囲指定もできる
$ echo /usr/bin/[A-V]*

AからVまでで始まらないみたいな指定も可能
$ echo /usr/bin/[^A-V]*
```

### ブレース{}展開
```
,で区切ると一つ一つ展開
$ echo {aa,bb,cc}
aa bb cc

シーケンス式も指定できる　XからCまで (記号を含むことと大文字が先であることに注意)
$ echo {X..c}
X Y Z [  ] ^ _ ` a b c

シーケンス式では、インクリメント（この場合は2）を指定できる
$ echo {f..y..2}
f h j l n p r t v x

応用例 シーケンス式で連番のディレクトリを作る
$ mkdir dir{A,B}{1..3}
$ ls
dirA1  dirA2  dirA3  dirB1  dirB2  dirB3
```

### xargs
パイプからの標準入力を空白や改行区切りで引数として、指定したコマンドの末尾に渡され、順次実行する。
```
findで検出した90日以上前の通常ファイルを削除するコマンド
$ find */dirA1 -mtime +90 -type f | xargs rm -rf
```