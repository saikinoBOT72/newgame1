#!/bin/sh
# prototype/index.html は artifact 用の断片（doctype/html/head/body を持たない）。
# GitHub Pages で直接開けるよう、完全な HTML 文書に包んで docs/index.html を作る。
set -e
cd "$(dirname "$0")"
{
  cat docs/_head.html
  cat prototype/index.html
  printf '\n</body>\n</html>\n'
} > docs/index.html
echo "docs/index.html を生成しました"
