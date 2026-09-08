#!/usr/bin/env python3
"""戦闘画面を組み立てる。

  src/b_*.txt   … 中身。この順につないで 1 つの <script> にする
  cards/*.png   … 札の絵。ファイル名がそのまま札の id になる
  wheel.png     … 盤の絵（回っていないときの下地）

札の絵は<b>表示するちょうどの大きさに面積平均で落としてから</b>埋め込む。
ブラウザに縮めさせると 1 仮想ドットと絵の 1 画素がずれて、格子が壊れる。
色は丸めない（丸めると小さい面積の赤などが茶に転ぶ）。
"""
import base64, glob, io, os, sys
from PIL import Image

HERE  = os.path.dirname(os.path.abspath(__file__))
CW, CH = 110, 154                      # 画面に出る札の大きさ

PARTS = ["b_head", "b_core", "b_shapes", "b_wheel",
         "b_game", "b_parts", "b_scene", "b_boot"]

def uri_png(im):
    b = io.BytesIO(); im.save(b, format="PNG", optimize=True)
    return "data:image/png;base64," + base64.b64encode(b.getvalue()).decode()

def card_uri(path):
    im = Image.open(path).convert("RGBA")
    bb = im.split()[3].getbbox()                    # 透明な余白を落とす
    if bb: im = im.crop(bb)
    w, h = im.size
    if abs(w / h - CW / CH) > 0.03:
        print(f"  ! {os.path.basename(path)} の比が 7:5 から外れています "
              f"({w}x{h} = {w/h:.3f} / 期待 {CW/CH:.3f})", file=sys.stderr)
    return uri_png(im.resize((CW, CH), Image.BOX).convert("RGB"))

def main():
    cards = sorted(glob.glob(os.path.join(HERE, "cards", "*.png")))
    if not cards: sys.exit("cards/ に札の絵がありません")
    js  = ("/* 札の絵。cards/ に置いた PNG を、1 仮想ドット＝絵の 1 画素になる\n"
           "   大きさ（%d×%d）に面積平均で落としたもの。色は丸めていない。\n"
           "   ファイル名がそのまま札の id。build.py が作る。 */\n" % (CW, CH))
    js += "const CARD_IMG = {\n"
    for f in cards:
        name = os.path.splitext(os.path.basename(f))[0]
        print("  札", name)
        js += '  %s: "%s",\n' % (name, card_uri(f))
    js += "};\n"
    js += 'const WHEEL_IMG = "%s";\n' % uri_png(Image.open(os.path.join(HERE, "wheel.png")))

    src = "\n".join(io.open(os.path.join(HERE, "src", p + ".txt"),
                            encoding="utf-8").read() for p in PARTS)
    if "const INK" not in src: sys.exit("src が壊れています（INK が無い）")
    src = src.replace('const INK = "#07090b";', 'const INK = "#07090b";\n' + js, 1)
    io.open(os.path.join(HERE, "app.html"), "w", encoding="utf-8").write(src)
    print("  game/battle/app.html を作りました（%d KB / 札 %d 枚）"
          % (len(src.encode()) // 1024, len(cards)))

main()
