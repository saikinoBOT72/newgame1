# 射的の杖

落ちた順が呪文の順になる、射的ローグライト。

棚に並んだカードをコルクで撃ち落とす。**落ちた順序がそのまま杖（呪文）の並び順**になり、
修飾カードは次の発射体カードに乗る。同じ詠唱で撃つほど発射体の威力は落ちるので、
「先頭の 1 枚に修飾を積む」ことが射的の目標になる。

## 遊ぶ

**https://saikinobot72.github.io/newgame1/**

全画面は右上の `⛶` ボタンか `F` キー。戻すのは `F` か `Esc`。

## 構成

| ファイル | 役割 |
|---|---|
| `prototype/index.html` | ゲーム本体。単一ファイル。HTML 断片（doctype / html / head / body を持たない） |
| `prototype/head.html` | スタンドアロン版の head |
| `index.html` | `build.sh` が生成する GitHub Pages 用の完全な HTML 文書。直接編集しない |
| `build.sh` | 直下の `index.html` を生成する |
| `DESIGN.md` | 設計記録。判断とその理由、実測値 |

本体を編集したら `./build.sh` を実行してから commit する。

## Pages

Settings → Pages の Source は **Deploy from a branch / main / (root)**。
直下に `index.html` があるので、README ではなくゲームが開く。
`.nojekyll` を置いて Jekyll の変換を止めている。
