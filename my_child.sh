#!/bin/bash
#親の環境変数が使えることを確認する。
echo "${ENV_VAR}"

#親が子の環境変数、シェル変数を参照するための準備。
export CHILD_ENV_VAR="I'm a child."
child_var="I'm a child's var."