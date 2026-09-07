#!/bin/sh
# 各ディレクトリの head.html + app.html（artifact 用の断片。doctype/html/head/body を
# 持たない）を、完全な HTML 文書に包んで index.html を作る。
# Pages の公開元がルートなので、直下に index.html があれば README ではなく画面が開く。
set -e
cd "$(dirname "$0")"

# ルートに出すのは試作版の戦闘画面。ここが本線。
{
  cat game/battle/head.html
  cat game/battle/app.html
  printf '\n</body>\n</html>\n'
} > index.html
echo "index.html（戦闘画面）を生成しました"

# 元のゲーム（prototype/）は old/ に置いておく。参考用で、もう本線ではない。
mkdir -p old
{
  cat prototype/head.html
  cat prototype/index.html
  printf '\n</body>\n</html>\n'
} > old/index.html
echo "old/index.html（元のゲーム）を生成しました"

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

# 戦闘画面は game/battle/ にも同じものを置く（ルートと同じ中身）
cp index.html game/battle/index.html
echo "game/battle/index.html を生成しました"

# 試作版のゲーム UI（戦闘画面のレイアウト案。見た目だけ）
{
  cat game/ui-demo/head.html
  cat game/ui-demo/app.html
  printf '\n</body>\n</html>\n'
} > game/ui-demo/index.html
echo "game/ui-demo/index.html を生成しました"

# 差し替え版（区画の数・中身・色を変えられる。賭けなし）
{
  cat wheel/head.html
  cat wheel/app.html
  printf '\n</body>\n</html>\n'
} > wheel/index.html
echo "wheel/index.html を生成しました"

# ドット版（物理は 3D、絵は低解像度＋色数を絞る）
{
  cat roulette-dot/head.html
  cat roulette-dot/app.html
  printf '\n</body>\n</html>\n'
} > roulette-dot/index.html
echo "roulette-dot/index.html を生成しました"
