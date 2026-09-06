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

# 3D 版
{
  cat roulette3d/head.html
  cat roulette3d/app.html
  printf '\n</body>\n</html>\n'
} > roulette3d/index.html
echo "roulette3d/index.html を生成しました"

# 俯瞰版（物理は 3D、絵は斜投影の 2D）
{
  cat roulette-top/head.html
  cat roulette-top/app.html
  printf '\n</body>\n</html>\n'
} > roulette-top/index.html
echo "roulette-top/index.html を生成しました"

# ドット版（物理は 3D、絵は低解像度＋色数を絞る）
{
  cat roulette-dot/head.html
  cat roulette-dot/app.html
  printf '\n</body>\n</html>\n'
} > roulette-dot/index.html
echo "roulette-dot/index.html を生成しました"
