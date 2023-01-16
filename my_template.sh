#!/bin/bash
set -euo pipefail
# 最初に書くシェバンはインタプリタの指定 #!/bin/shとする情報も多いが、shがどのインタプリタを指すかは環境により異なる。
# set -euo pipefailでシェル設定を変更する。エラー発生時、未定義変数の使用時にスクリプトの実行を停止し、意図しない動作を防ぐことができる。

# 変数の入力、=の前後にスペースをおけないことに注意。
var="bar"

# 変数を参照する際は${}で囲う。囲わなくても参照できるが、変数に続く文字列によっては意図しない展開が行われることがある。
echo ${var}

# 環境変数の定義
export ENV_VAR="I'm a parent."

# シェルスクリプトからシェルスクリプトを呼び出す場合、子スクリプトは別のプロセスとして呼ばれる。
# 情報を引き継ぐには環境変数を使う。親から子へは引き継げるが、子から親へは引き継げないので注意。
./my_child.sh

# 子の変数を引き継ぎたい場合は、sourceを使う。呼び出した子スクリプトは親と同じプロセスで実行されるので子の変数を使える。
source my_child.sh

# 子の環境変数、シェル変数を使える。
echo "${CHILD_ENV_VAR}"
echo "${child_var}"

# 入力の受付
echo "1~10の整数を入力してください。"
read -r num

# if文
if [ "${num}" -gt 10 ] || [ "${num}" -le 0 ]; then #条件式は[  ]でくくる。-gtはgreater than、-leはless or equal
    echo "入力したのは1~10の整数ではありません。"

elif [ "${num}" -eq 7 ]; then
    echo "ラッキーナンバー 7 です！"
else
    echo "ラッキーナンバーではありません。残念!"
fi

# 変数の細かい属性をdeclare宣言する。 -i は整数として扱う宣言。
declare -i i=0

# while文
while [ $i -lt 2 ]; do
    # echo -n は改行なし出力
    echo -n "ループを終了しますか？[Y/n]:"
    read -r input

    # case文
    case "$input" in
    [yY]es | YES | [yY]) # yes,Yes,YES,y,Yの場合
        echo "[YES]ループ中断"
        break
        ;;
    [nN]o | NO | [nN]) # no,No,NO,n,Nの場合
        echo "[NO]ループ継続"
        ;;
    *) # それ以外
        echo "[YES/NO]以外が入力されました"
        ;;
    esac
    
    i=$((++i))
done

# for文
for ((j = 0; j <= 7; j++)); do
    echo "${j}"
done

# 関数 ファイルを１行ずつ読み出す
function read_test_txt() {
    while read -r line; do
        echo "${line}"
    done <test.txt 
}
read_test_txt