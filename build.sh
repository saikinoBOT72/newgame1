#!/bin/sh
# prototype/index.html は artifact 用の断片（doctype/html/head/body を持たない）。
# GitHub Pages で直接開けるよう、完全な HTML 文書に包んでリポジトリ直下の
# index.html を作る。Pages の公開元がルートなので、ここに index.html があれば
# README ではなくゲームが開く。
set -e
cd "$(dirname "$0")"
{
  cat prototype/head.html
  cat prototype/index.html
  printf '\n</body>\n</html>\n'
} > index.html
echo "index.html を生成しました"

# ルーレット（単体・ローグライクとは無関係）も同じやり方で包む
{
  cat roulette/head.html
  cat roulette/app.html
  printf '\n</body>\n</html>\n'
} > roulette/index.html
echo "roulette/index.html を生成しました"
